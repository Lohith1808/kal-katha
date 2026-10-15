# Kal Katha — Development & Workflow Protocols

## 1. Controlled Three-Stage Workflow

All game content, features, and milestones in Kal Katha must strictly follow a three-stage pipeline:

```
┌─────────────────────────┐      Owner       ┌──────────────────────┐      Owner       ┌──────────────────────────────┐
│ 1. Historical Research  │ ─── Approval ──► │   2. Game Design     │ ─── Approval ──► │    3. Godot Implementation   │
│ (Source Verification)   │                  │ (Pedagogy & Systems) │                  │     (Engine & Testing)       │
└─────────────────────────┘                  └──────────────────────┘                  └──────────────────────────────┘
```

**Rule of Progression**: Explicit project owner approval is strictly required before moving any artifact between stages. No code or design artifact may precede approved research.

### Stage 1: Historical Research Protocol
1. **Source Hierarchy**:
   - Primary reference must come from the owner-approved canonical textbook and edition.
   - Secondary archival references must be documented with title, author, publication, and specific citation details.
2. **Dossier Requirement**:
   - Every chapter must have a dedicated Markdown dossier filed under `content/{ancient|medieval|modern}/`.
   - Dossiers must specify: historical timeframe, verified historical events, verified entities/people, verified locations, primary quotes, and full academic citations.
3. **No Automatic Fact Generation (AGENTS.md Rules 1–4)**:
   - AI assistants must never invent, extrapolate, or hallucinate historical facts, dates, or outcomes.
   - If a historical detail is uncertain or undocumented in the approved textbook, flag the gap for owner review.

### Stage 2: Gameplay Design Protocol
1. **Fidelity to Approved Dossiers**:
   - Game mechanics and narrative scenarios must derive exclusively from the approved historical dossier.
   - Gameplay may simplify presentation for educational clarity but must never claim invented events are historical facts (AGENTS.md Rule 5).
2. **Deterministic Checkpoint Reset (AGENTS.md Rules 6 & 7)**:
   - Alternate history and branching historical outcomes are strictly prohibited.
   - Gameplay failure must reset cleanly to the previous checkpoint rather than branching the timeline.
3. **Pedagogical Alignment**:
   - Every interactive beat must reinforce historical understanding and source awareness.

### Stage 3: Godot Implementation & Testing Protocol
1. **Separation of Concerns (AGENTS.md Rule 8)**:
   - Historical records are loaded via `HistoricalChapter` and `SourceReference` resources.
   - Game scenes, UI scripts, and controllers must never contain hardcoded historical facts.
2. **Visual & Aesthetic Standards**:
   - Maintain the restrained historical visual quality established in the Home Screen (dark slate, stone, antique brass, parchment typography).
   - Use Godot native UI controls and procedural theme overrides unless explicit asset approval is granted.
3. **Engine Standards**:
   - Target Godot 4.7.2. Write clean, typed GDScript with `class_name` identifiers.
   - Keep scenes modular with clear responsibility separation.

---

## 2. Antigravity Pair-Programming Task Protocol

Every Antigravity assistant task must adhere to the following execution constraints:

1. **One Bounded Objective**: Tasks must address a single, well-defined goal. Never combine multiple milestones into one task.
2. **Explicit Scope**:
   - Explicitly list in-scope files.
   - Explicitly list out-of-scope files.
3. **Minimal Plan**: Present a concise plan detailing expected file additions or modifications before modifying code.
4. **Defined Acceptance Criteria**: State concrete, measurable criteria for success.
5. **Handling Ambiguity & Missing Dependencies**:
   - If user requirements are ambiguous, underspecified, or a dependency is missing, **stop and ask for clarification** rather than making assumptions.
6. **Rigorous Verification & Honest Reporting**:
   - Run relevant checks, inspect syntax, and test code.
   - Honestly report actual verification results. Never claim that a feature (e.g., checkpoint recovery, save persistence, or automated tests) works unless physical evidence and test execution confirm it.
7. **Diff Review**: Inspect `git diff` after modifications to ensure no unintended files or lines were altered.
8. **Final Structured Report**: Provide a concise summary containing:
   - Exact files changed and rationale.
   - Verification steps conducted.
   - Identified failures, limitations, or deviations.
   - Unverified items.
9. **Strict Stopping Boundary**: Stop immediately at the approved task boundary. Do not unilaterally begin subsequent milestones or implement unsolicited features.
