# Kal Katha — Project Status & Milestone Ledger

## 1. Project Overview & Environment

- **Project Name**: Kal Katha
- **Repository Path**: `D:\FOF\Projects\Kal Katha`
- **Main Scene**: `res://scenes/ui/home_screen.tscn` (configured in `project.godot`)
- **Inspected Engine Environment**: Godot 4.7.2-stable (Windows 64-bit).
  - *Engine Compatibility Note*: Repository configuration is set to Godot 4.7.2 (`config/features=PackedStringArray("4.7")`). Compatibility with Godot 4.3 or earlier versions is completely unverified, as no test evidence exists.

---

## 2. Milestone & Sprint Ledger

This ledger explicitly distinguishes between **owner-confirmed handoffs**, **code observed in repository**, **behavior actually tested**, and **future plans**.

### Sprint 1 — Foundation
- **Status**: Completed according to project owner's handoff.
- **Code Observed**:
  - Base directory structure: `scenes/`, `scripts/`, `assets/`, `content/`.
  - Content placeholders: `content/ancient/`, `content/medieval/`, `content/modern/`.
  - Core scripts: [scripts/core/save_manager.gd](file:///D:/FOF/Projects/Kal%20Katha/scripts/core/save_manager.gd), [scripts/main.gd](file:///D:/FOF/Projects/Kal%20Katha/scripts/main.gd).
  - Data contracts: [scripts/data/historical_era.gd](file:///D:/FOF/Projects/Kal%20Katha/scripts/data/historical_era.gd), [scripts/data/source_reference.gd](file:///D:/FOF/Projects/Kal%20Katha/scripts/data/source_reference.gd), [scripts/data/historical_chapter.gd](file:///D:/FOF/Projects/Kal%20Katha/scripts/data/historical_chapter.gd).
  - Foundation entry scene: [scenes/main.tscn](file:///D:/FOF/Projects/Kal%20Katha/scenes/main.tscn).
- **Owner-Reported Status**: Save file serialization/deserialization logic was reported as working by the project owner at handoff.
- **Behavior Tested**: No automated tests or execution logs exist in the repository; save I/O remains unverified by test execution.
- **Limitations**: No historical data instances were created or loaded.

### Sprint 2 — Home Screen
- **Status**: Completed according to project owner's handoff.
- **Code Observed**:
  - Main scene: [scenes/ui/home_screen.tscn](file:///D:/FOF/Projects/Kal%20Katha/scenes/ui/home_screen.tscn) with controller [scripts/ui/home_screen.gd](file:///D:/FOF/Projects/Kal%20Katha/scripts/ui/home_screen.gd).
  - Reusable component: [scenes/ui/components/historical_menu_button.tscn](file:///D:/FOF/Projects/Kal%20Katha/scenes/ui/components/historical_menu_button.tscn) with script [scripts/ui/components/historical_menu_button.gd](file:///D:/FOF/Projects/Kal%20Katha/scripts/ui/components/historical_menu_button.gd).
  - Visual styling: Dark slate, antique brass, and parchment tones implemented via Godot native `StyleBoxFlat` and typography overrides without external asset dependencies.
- **Owner-Confirmed Status**: The project owner confirmed that the Home Screen runs and satisfies the required visual style.
- **Behavior Tested**: No automated tests or interaction test logs exist in the repository. Individual behaviors (e.g., hover slide tweens, diamond marker fades, locked state evaluation, drawer transitions) are written in GDScript but remain unverified by formal test runs.
- **Quality Mandate**: The visual quality, restrained aesthetic, and responsiveness of the Home Screen must be strictly preserved in all subsequent work.
- **Limitations**: Menu buttons are wired to display prototype informational drawers; gameplay scene loading is not implemented.

---

## 3. Current Milestone & Next Steps

- **Current Milestone**: Project Preparation and Historical-Source Selection.
- **Historical Source Status**:
  - Canonical history textbook and edition: **Not yet selected**.
  - Approved historical dossiers: **None**.
- **Immediate Next Milestone**: Selecting and approving the canonical history textbook and edition with the project owner.
- **Explicit Negative Scope**: Do not implement gameplay, chapter scene transitions, or historical content until the canonical textbook is approved and the first dossier is verified.

---

## 4. Architecture & Technical Decisions

1. **Strict Separation of Content and Code (AGENTS.md Rules 3 & 8)**:
   - Historical records are defined strictly as Godot `Resource` data contracts ([scripts/data/historical_chapter.gd](file:///D:/FOF/Projects/Kal%20Katha/scripts/data/historical_chapter.gd)) referencing [scripts/data/source_reference.gd](file:///D:/FOF/Projects/Kal%20Katha/scripts/data/source_reference.gd).
   - Presentation and gameplay code never hardcode historical facts.
2. **Local Persistence Architecture (AGENTS.md Rule 7)**:
   - Handled via static methods in [scripts/core/save_manager.gd](file:///D:/FOF/Projects/Kal%20Katha/scripts/core/save_manager.gd) writing to `user://save_data.json`.
   - Defines schema fields (e.g., `current_checkpoint_id`) to store checkpoint metadata. The gameplay failure-and-restart loop is not implemented or verified.
3. **Restrained Historical UI Design System**:
   - Built exclusively with Godot native controls, custom `StyleBoxFlat` resources, and procedural color modulation.
   - Clean 1920×1080 canvas item layout supporting consistent presentation across resolutions.

---

## 5. Incomplete, Unverified, and Future Systems

| Component | Status | Details |
| :--- | :--- | :--- |
| Canonical Textbook | **Not selected** | Requires owner review and selection. |
| Historical Dossiers | **None approved** | `content/ancient/`, `content/medieval/`, and `content/modern/` contain only `.gitkeep`. |
| Chapter Scene Loading | **Not implemented** | Menu buttons currently open informational prototype drawers. |
| Checkpoint Rollback Loop | **Not implemented / Unverified** | SaveManager stores checkpoint metadata, but the gameplay failure-and-restart loop is not implemented or verified. |
| Settings & Audio Buses | **Not connected** | Volume settings exist in save schema, but audio buses and controls are unlinked. |
| Automated Testing | **Not configured** | No automated unit or integration test suite currently exists. |
