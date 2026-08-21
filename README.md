# 🥷 Karate API Automation Project

![Java](https://img.shields.io/badge/Java-21-blue)
![Maven](https://img.shields.io/badge/Maven-3.9.0-green)
![Karate](https://img.shields.io/badge/Karate-1.4.1-orange)
![JUnit5](https://img.shields.io/badge/JUnit-5.10.0-red)

---

Bienvenue sur le projet **Karate API Automation** ! 🚀  
Ce projet permet de réaliser des tests d'API automatisés avec **Karate**, générer des rapports détaillés et suivre facilement les statuts des tests.

---

## 📦 Technologies utilisées

- **Java 21**
- **Karate 1.4.1**
- **JUnit 5**
- **Cucumber Reporting**
- **Maven**
- **org.json** pour parser les fichiers JSON

---

## ⚙️ Prérequis

- [Java 21](https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html)
- [Maven](https://maven.apache.org/install.html)
- IDE recommandé : IntelliJ IDEA ou Eclipse

---

## 📥 Installation

1. Clonez le projet :

git clone https://github.com/votre-utilisateur/karate-api-project.git

Installez les dépendances Maven :

mvn clean install

---

## 🏃 Exécution des tests
1️⃣ Avec Maven
mvn test

2️⃣ Avec IntelliJ IDEA

Ouvrez TestRunner.java dans src/test/java/execution/scenarios

Faites un clic droit → Run 'TestRunner'

---

## 🔧 Paramètres

Tests exécutés en série (modifiable en parallèle)

Rapports générés automatiquement dans :

target/karate-reports

---

## 📊 Rapports

Après exécution, vous trouverez :

Rapport HTML détaillé :

target/karate-reports/karate-summary.html


Rapports JSON pour intégration continue :

target/karate-reports/*.json

Informations affichées :

✅ Tests réussis

❌ Tests échoués

⏱️ Temps d’exécution par scénario

---

## 📝 Logs détaillés

Les rapports utilisent Cucumber Reporting pour un rendu clair et esthétique.

---

## 🌐 Configuration des environnements

Dans karate-config.js :

function fn() {
  var env = karate.env; // valeur par défaut: 'staging'
  var config = {
      baseUrl: 'https://votre-api.com'
  };
  return config;
}


Les fichiers .feature sont situés dans :

src/test/resources/features

---

## 📁 Structure du projet
```
karate-api-project

│
├── src
│   ├── test
│   │   ├── java
│   │   │   └── execution/scenarios/TestRunner.java
│   │   └── resources
│   │       └── features/
│   │           └── *.feature
│   └── karate-config.js
├── pom.xml
└── README.md
``` 

---

## 🤝 Contribution

Fork le projet

Créez une branche :

git checkout -b feature/nom-feature


Committez vos modifications :

git commit -m "Ajout d’un nouveau test"


Push sur la branche :

git push origin feature/nom-feature


Ouvrez une Pull Request