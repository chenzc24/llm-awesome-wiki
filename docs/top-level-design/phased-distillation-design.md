# Phased Distillation Design

本文定义从 `raw_resource` 到可审计 Markdown Wiki 的顶层阶段设计。它服务于
后续执行计划派生，不是一次性任务清单。

核心判断：不要让模型裸读原始二进制文件。LLM 可以帮助理解、caption、分类、
生成和合并，但原始文件解析、媒体抽取、路径归一、哈希、分页、质量报告和
落盘规则应先由确定性工具完成。

## Design Position

本项目的知识构建主线分成三层：

1. 原始证据层：保留原文件，不改写。
2. 源转换层：把不同模态资源转成可引用、可检查、可索引的 Markdown source
   packet。
3. Wiki 蒸馏层：基于 source packet 生成 `wiki/` 页面、索引、日志、审查项和
   compare gate 报告。

`raw_resource -> .md` 不等于“总结成 Wiki”。它先应转成忠实的 source packet：
保留结构、页码、图表位置、媒体引用、提取失败点和 provenance。Wiki 页面是
下一阶段的蒸馏结果。

Recommended future shape:

```text
raw/sources/                         # immutable original files
raw/inventory.yml                    # source identity, type, hash, status
raw/derived/<source-id>/source.md    # extracted source packet
raw/derived/<source-id>/media/       # extracted images, page renders, slides
wiki/sources/<source-id>.md          # distilled source summary
wiki/concepts|entities|.../*.md      # distilled knowledge pages
reports/compare/<round-id>.md        # coverage and quality reports
```

如果现有数据目录仍叫 `raw_resource/`，执行计划可以先把它映射为“原始证据层”，
再决定是否迁移到 `raw/sources/`。顶层规则不依赖具体目录名，但必须保留“原始
文件不可改写”和“转换产物单独落盘”这两个边界。

## Phase 0: Design Seed And Scope

Goal: 选定一轮要处理的资源范围，并确定本轮是否只做转换、还是继续进入 Wiki
蒸馏。

Questions to answer:

- 本轮处理哪些 source group、文件类型和主题？
- 是否需要先建立目录和 inventory？
- 本轮是否允许生成 `wiki/` 页面，还是只生成 `raw/derived/` source packet？
- 哪些判断需要人工确认？

Deliverables:

- target-specific `plan/<date-goal-slug>/plan.md`
- source group definition
- validation checklist

Validation:

- Git 工作区干净后开始。
- `llm_wiki/` 只作为 reference submodule，不改子模块内容。
- 本轮目标不混合过多阶段。

`llm_wiki` reference:

- `docs/llm_wiki-reference.md` 中的边界规则。
- `llm_wiki/src/lib/file-types.ts` 的文件类型分类思路。

## Phase 1: Raw Resource Inventory

Goal: 先知道有什么，再决定怎么转。

每个 raw resource 至少记录：

- `source_id`: 稳定 ID，优先由 `raw/sources/` 相对路径生成；同名冲突时加短 hash。
- `raw_path`: 原始文件路径。
- `kind`: `markdown | text | code | pdf | pptx | docx | image | audio | video | data | unknown`。
- `sha256`: 原始文件 hash。
- `size_bytes`
- `modified_time`
- `owner/status`: `new | extracted | partial | distilled | blocked | archived`
- `modalities`: `text | image | table | chart | audio | video | layout`
- `notes`: 密码保护、扫描件、低质量 OCR、缺失依赖等。

Rules:

- 不根据扩展名直接进入 LLM 总结。扩展名只决定预处理路线。
- 同一个文件的 ID 必须稳定，重跑不应生成不同文件名。
- inventory 是 compare gate 的输入，不是可选备注。

`llm_wiki` reference:

- `source-identity.ts`: 用相对路径生成 source identity，并为嵌套路径生成稳定 slug。
- `ingest-cache.ts`: 用 SHA-256 避免未变化资源重复 ingest。
- `file-types.ts`: 区分 text-readable、document、image、data 等类别。

## Phase 2: Modality-Aware Extraction

Goal: 用工具把原始资源拆成文本、结构、媒体和 metadata，再交给模型。

### Plain Text, Markdown, Code, Data

处理方式：

- 直接读取为文本。
- 保留标题、代码块、表格、链接和已有图片引用。
- JSON/YAML/CSV 等结构化数据优先保留原结构；必要时生成简短 schema 摘要。

LLM role:

- 可以用于解释、分类、抽取概念。
- 不应负责猜测文件结构或修复解析失败。

### PDF

PDF 不能简单让模型裸读。原因包括：

- 很多模型或工具只能读文本上下文，无法直接访问本地 PDF 二进制。
- PDF 可能有文本层、扫描图像、矢量图、嵌入图片、表格和复杂版式。
- 即使 VLM 能看页面截图，也会受上下文、成本和细节精度限制。

处理路线：

1. 用 PDF parser 提取每页文本，保留 `## Page N`。
2. 对无文本层或疑似扫描页运行 OCR 或页面截图 caption。
3. 抽取嵌入图片，保存到 source media 目录。
4. 对矢量图表或版式重要页面，渲染整页截图作为 fallback。
5. 图片、图表、截图由 VLM 生成 factual caption；caption 标记为模型生成。
6. 记录 extraction gaps：密码保护、空页、OCR 低置信度、矢量图未解析等。

`llm_wiki` reference:

- `src-tauri/src/commands/fs.rs`: PDF 文本提取和页结构。
- `src-tauri/src/commands/extract_images.rs`: PDF 图片抽取、尺寸过滤、`max_images`
  上限、SHA-256。
- `plans/multimodal-images.md`: caption-first hybrid 方案。

### PPTX

PPTX 是 zip 包，不应让模型从文件名猜幻灯片内容。

处理路线：

1. 解析 `ppt/slides/slideN.xml` 获取 slide 文本。
2. 解析 speaker notes，如果存在则作为单独 section。
3. 提取 `ppt/media/*` 图片，并通过 slide relationships 尽量映射到 slide。
4. 对每页幻灯片渲染 screenshot，捕获布局、图表、箭头和视觉层级。
5. 只把有意义的图片或截图送 VLM caption，跳过小图标和装饰。
6. Source packet 使用 `## Slide N`，保留标题、bullet、notes、媒体引用和 caption。

LLM role:

- 可以根据 slide 文本和 caption 识别主题、结构、决策、方法。
- 不应单独负责还原 slide 顺序、图片归属或表格结构。

`llm_wiki` reference:

- `fs.rs` 中 PPTX slide XML 文本提取。
- `extract_images.rs` 中 OOXML media 抽取和 slide number heuristic。
- `extract-source-images.ts` 中媒体保存到 `wiki/media/<source-slug>/` 的路径思路。

### DOCX

DOCX 也是 OOXML zip 包，处理重点是段落结构、标题层级、表格、脚注、图片和批注。

处理路线：

1. 用 DOCX parser 提取 heading、paragraph、list、table。
2. 表格较小时转 Markdown table；大表格转 companion CSV/TSV，并在 source packet
   中链接。
3. 提取 `word/media/*` 图片，保存并 caption。
4. 脚注、尾注、批注和修订痕迹如果存在，单独标记。
5. 保留章节层级，不把整篇压成连续散文。

LLM role:

- 可以帮助判断章节意图、概念和可蒸馏页面。
- 不应负责从二进制 DOCX 中自行“读出”真实结构。

`llm_wiki` reference:

- `fs.rs` 中 DOCX 解析和 `word/document.xml` fallback。
- `extract_images.rs` 中 `word/media/*` 抽取。

### Images

独立图片不应直接变成“总结页”。先成为 source packet：

- 保存原图路径、hash、尺寸、格式。
- OCR 可见文本。
- VLM caption 描述图像、图表轴、标注、箭头和关键元素。
- 如果图片来自某篇文档，保留 parent source 和页码/slide 编号。

`llm_wiki` reference:

- `vision-caption.ts`: factual caption prompt、context-aware caption、低温度输出。
- `image-caption-pipeline.ts`: caption cache 和批处理思路。

## Phase 3: Source Packet Markdown Contract

Goal: 把抽取结果写成忠实、可审计的 `.md`，作为模型蒸馏输入。

Source packet 必须满足：

- 第一行是 YAML frontmatter。
- 所有重要片段都能追溯到原始 source、页码、slide 或 section。
- 工具抽取内容和模型生成内容要明确区分。
- 不输出绝对路径；媒体路径应相对 source packet 或 wiki root。
- 不在这一阶段做大幅总结、价值判断或跨源综合。

Suggested frontmatter:

```yaml
---
type: source-extract
source_id: ai-paper-2026
raw_path: raw/sources/papers/ai-paper.pdf
raw_sha256: "<sha256>"
source_kind: pdf
extraction_version: raw2md-v0
extraction_status: partial
modalities: [text, image, table]
generated_fields: [image_captions]
created: 2026-06-03
---
```

Suggested body:

```markdown
# Source Extract: ai-paper-2026

## Extraction Summary

- Text layer: present
- Images extracted: 8
- OCR pages: 0
- Known gaps: vector charts not rasterized

## Media Index

| id | page/slide | path | sha256 | generated caption status |
| --- | --- | --- | --- | --- |
| img-001 | Page 3 | media/img-001.png | ... | captioned |

## Page 1

Extracted text here.

## Page 3

Extracted text here.

![Generated caption text.](media/img-001.png)

## Extraction Notes

- Page 12 had low OCR confidence.
```

Conversion rules:

- PDF pages become `## Page N`.
- PPTX slides become `## Slide N`; speaker notes become `### Speaker Notes`.
- DOCX heading levels are preserved when available.
- Tables remain tables when small and readable; otherwise link to a companion data file.
- Captions use factual language and no speculation.
- Missing or failed extraction is written as a note, not silently ignored.

`llm_wiki` reference:

- `buildImageMarkdownSection()` in `extract-source-images.ts` for page-grouped media blocks.
- `sanitizeIngestedFileContent()` for cleaning malformed LLM-emitted frontmatter.
- `raw-source-resolver.ts` for mapping media references back to raw sources.

## Phase 4: First LLM Analysis Pass

Goal: 让模型读 source packet，而不是读原始二进制，生成结构化 analysis。

The analysis should cover:

- key entities
- key concepts and methods
- main claims and evidence
- source limitations and confidence
- relationships to existing wiki pages
- contradictions or tensions
- recommended wiki pages to create or update

LLM boundaries:

- 可以综合 source packet 中的文本、OCR、caption 和 extraction notes。
- 必须引用页码、slide 或 section，不得只写“来源称”。
- 对 caption/OCR 产生的事实要降低置信度或标记为 generated evidence。
- 不把 analysis 直接当最终 Wiki 页面。

`llm_wiki` reference:

- `buildAnalysisPrompt()` in `ingest.ts`: 先 analysis，再生成 Wiki 文件。
- `splitSourceIntoSemanticChunks()` 和 long-source checkpoint 思路：长文档分块分析，
  不靠截断后的最后上下文。

## Phase 5: Wiki Page Generation

Goal: 基于 analysis 和 source packet 生成 `wiki/` 页面。

Expected outputs:

- `wiki/sources/<source-id>.md`
- schema-defined typed pages, or fallback to `wiki/entities/` and `wiki/concepts/`
- updated `wiki/index.md`
- updated `wiki/overview.md`
- `wiki/log.md` entry
- review items for unresolved judgment

Rules:

- 每个重要页面都必须有 frontmatter。
- `sources` 字段必须包含 `source_id` 或 source reference。
- 正文使用 `[[wikilink]]`，frontmatter 中不要写 wikilink 语法。
- 图片引用只能使用稳定相对路径。
- 同一页面由多个来源贡献时，合并 sources、tags、related，不能覆盖旧来源。

`llm_wiki` reference:

- `buildGenerationPrompt()` in `ingest.ts`: FILE/REVIEW block 输出格式、frontmatter
  规则、source summary 固定路径。
- `sources-merge.ts`: frontmatter array 字段 union merge。
- `page-merge.ts`: LLM 合并正文后再做 deterministic safety checks。

## Phase 6: Compare Gate And Review Queue

Goal: 防止模型自评成为唯一质量门。

Checks:

- Source coverage: 每个 source packet 是否有对应 `wiki/sources/` 页面。
- Claim coverage: 关键 claim 是否能追溯到 source packet 的页码/slide/section。
- Modality coverage: 图片、图表、OCR 页是否被摘要或明确标记为 skipped。
- Omission check: source packet 中高价值 section 是否没有进入 Wiki。
- Contradiction check: 与已有 Wiki 冲突时进入 review queue。
- Link check: `[[wikilink]]` 是否断链。
- Frontmatter check: required fields 是否存在且 parseable。
- Path check: Markdown 中不含本机绝对路径。

Outputs:

- `reports/compare/<round-id>.md`
- review items
- updated `plan/log.md`
- optional `wiki/log.md` entry

`llm_wiki` reference:

- `lint.ts`: broken link、orphan、semantic lint 思路。
- review store / sweep review modules: missing page、duplicate、contradiction、suggestion。
- graph/search insights 可以作为“发现 gap”的参考，但不是根仓库必需依赖。

## Phase 7: Construction Tooling

Goal: 把 Phase 1 到 Phase 6 的重复劳动做成 repo-native CLI/script，而不是每次靠聊天。

Tool candidates:

- source inventory generator
- raw-to-source-packet converter
- media extractor and OCR/caption runner
- source packet validator
- wiki frontmatter/link lint
- compare gate reporter
- review queue exporter

Execution principle:

- 工具生成报告，不应默认静默重写 Wiki。
- 自动修复只能处理低风险格式问题。
- 高价值语义判断进入 review queue。

`llm_wiki` reference:

- ingest cache、image caption cache、source lifecycle、lint、review、search。
- 不继承 Tauri UI、Obsidian graph 或桌面应用状态作为根仓库依赖。

## Phase 8: Downstream Knowledge-To-Code

Goal: 等 Wiki 稳定后，再把知识转成 executable specs、skills、tools、tests 和模板。

Entry criteria:

- source inventory 可用。
- source packet 与 wiki 页面有覆盖报告。
- 关键 claim 有来源追溯。
- compare gate 不再频繁发现基础结构错误。

Outputs:

- executable specs
- agent skills
- deterministic tools
- tests
- templates
- experiments

This phase is downstream. It must not be mixed with raw resource conversion or
Wiki construction tooling.

## LLM Responsibility Matrix

| Task | Tool first | LLM allowed | Human review |
| --- | --- | --- | --- |
| File identity, hash, path | required | no | rare |
| PDF/PPTX/DOCX text extraction | required | no | when failed |
| OCR | required | optional cleanup | low confidence |
| Image/chart caption | extraction required | yes, with VLM | important charts |
| Source packet writing | required | limited formatting help | schema changes |
| Entity/concept analysis | context required | yes | ambiguous cases |
| Wiki page generation | analysis required | yes | high-impact claims |
| Claim/source coverage | required | assist only | unresolved gaps |
| Contradiction resolution | report required | assist only | required |

Short answer to "can the LLM handle it?": the model can help after the source
has been converted into accessible context. It should not be the parser of
record for binary documents, layout, media extraction, hashes, source identity,
or final quality gates.

## Rules For Deriving Execution Plans

When creating a concrete `plan/<date-goal-slug>/plan.md`, select exactly one
main stage or a narrow adjacent pair:

- Good: "Build Phase 1 inventory template."
- Good: "Convert three PDF fixtures into source packets and validate media."
- Good: "Draft compare gate report format."
- Too broad: "Implement raw resource to executable skills."

Every execution plan derived from this document should name:

- selected phase
- source scope
- expected files
- validation commands
- whether `llm_wiki/` is reference-only or touched
- commit intent
