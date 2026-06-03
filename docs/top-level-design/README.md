# Top-Level Design

这个目录保存设计者维护的顶层计划。它不是执行日志，也不是每次任务都要修改的
`plan/` 文件；它描述长期稳定的架构判断、阶段边界、质量门和执行计划派生规则。

## Maintenance Role

- 由设计者维护，只在阶段边界、目录契约、质量门或核心流程发生变化时更新。
- 普通执行任务应从这里派生 `plan/<date-goal-slug>/plan.md`，不要直接把一次性
  任务细节塞进本目录。
- 执行计划必须说明采用了本目录中的哪个阶段、要交付哪些文件、如何验证。
- 本目录可以引用 `llm_wiki/` 的现成设计和实现，但不得要求根仓库依赖
  `llm_wiki` 桌面应用。

## Current Design Documents

- `phased-distillation-design.md`: 从 `raw_resource` 到可审计 Markdown Wiki 的
  分阶段设计，包括多模态资源处理、LLM 边界、转换规则、质量门和可参考的
  `llm_wiki` 模块。
