<img align="right" src="https://images-ext-2.discordapp.net/external/hrpFrk16sFgItzrEA6jXqeX0tLHKWG89-liZMjAy9eA/https/cdn-icons-png.flaticon.com/512/1261/1261163.png" alt="Unpacked logo" width="160" height="160">

# Unpacked

This project was developed during the 4th semester of EASV's Computer Science program as a final exam project for the Mobile Programming and Fullstack Development course.

## Description

Unpacked is a modern shopping list application that enables users to share and collaborate on their lists. The application is built for mobile devices using Flutter, while utilizing Firebase tools for persistence.


## Authors

- [@Ladam0203](https://github.com/Ladam0203)
- [@SergioMM0](https://github.com/SergioMM0)
- [@TawfikAzza](https://github.com/TawfikAzza)
- [@RomanMeasv](https://github.com/RomanMeasv)


## Documentation

[Report](https://docs.google.com/document/d/1FpRoCw_SIrGg7pVRUa22LWUwhFtcnoG-kpv8_O-hnGI/edit?usp=sharing)


## Run Locally

Clone the project

```bash
  git clone https://github.com/RomanMeasv/mp23_astr
```

Go to the project directory

```bash
  cd mp23_astr
```

Install dependencies

```bash
  flutter pub get
```

Start the application

```bash
  flutter run
```

## Known issues & fixes

#### Google Sign-in does not work with Firebase Auth emulator
As the Firebase Auth Emulator does not support Google sign in, this feature is unavailable while using the emulators. This can be circumvented via taking out the Firebase Auth emulator from the used suite. (Emulators for the Firestore and Cloud Functions are still required as they are utilized in the sign up/sign in process)
