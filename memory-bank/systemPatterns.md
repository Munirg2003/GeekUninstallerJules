# System Patterns: GeekUninstallerJules

## Architecture
- **Tech Stack**: Flutter for Desktop (Windows/Linux/macOS).
- **Pattern**: Provider for state management.
- **UI Architecture**: Single-window application with a central data table.

## Key Technical Decisions
- **List View**: Use a scrollable table-like structure for the application list.
- **Mock Service**: A dedicated service class to provide application data and handle simulated uninstallation logic.
- **Styling**: Mimic the classic Windows aesthetic of GeekUninstaller, including specific colors for highlighting.

## Design Patterns
- **Service Pattern**: For handling data and business logic separately from the UI.
- **Repository Pattern**: (Abstracted in service) To provide mock data.
