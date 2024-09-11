# Windows Hardening

## Services
Access windows services by typing `services.ms` into the run menu.

## Windows Registry
Container database that stores
- configuration settings
- essential keys
- shared preferences for Windows & 3rd party applications.
- Open with `regedit`

## Event Viewer
Contains all the log details:
- driver updates
- hardware failures
- changes in the OS
- invalid authentication attempts
- application crash logs

Event categories:
- Application
- System
- Security

Location:
- `eventvwr` in the run window
- `C:\WINDOWS\system32\config\folder`

## Telemtry
Microsoft data collection system that shares data (crash logs)
`diagtrack.dll`

Location:
`%ProgramData%\Microsoft\Diagnosis`
