# PAKA - Application Mobile E-commerce

## 👤 Auteur(s)
**PAKA Essosolim Joel & AGBO Akoko Ayawa Albertine**

---

## 🛠 Technologie Utilisée
**Flutter avec Dart**

---

## 📱 Description de l'Application
PAKA est une application mobile de commerce électronique développée en Flutter/Dart. L'application permet aux utilisateurs de :
- Parcourir un catalogue de produits avec interface multiplateforme
- Consulter les détails détaillés des produits
- Ajouter/supprimer des articles du panier
- Gérer leur panier d'achat en temps réel
- Finaliser leur commande

L'application offre une interface utilisateur cohérente et performante sur iOS et Android grâce à la portabilité de Flutter.

---

## ✅ Fonctionnalités Implémentées

- ✅ Affichage d'une liste de produits
- ✅ Détails du produit (description, prix, images)
- ✅ Système de panier d'achat
- ✅ Ajout/suppression de produits au panier
- ✅ Calcul du total du panier avec taxes
- ✅ Écran de paiement/commande
- ✅ Interface utilisateur avec Material Design
- ✅ Navigation fluide entre les écrans
- ✅ Gestion d'état avec Provider/Riverpod
- ✅ Support multiplateforme (iOS & Android)

---

## 📚 Bibliothèques Utilisées

| Bibliothèque | Version | Utilisation |
|---|---|---|
| Flutter | 3.13.x | Framework principal |
| Dart | 3.1.x | Langage de programmation |
| Provider | 6.0.x | Gestion d'état |
| Go Router | 11.x | Navigation fluide |
| HTTP | 1.1.x | Requêtes API |
| Cached Network Image | 3.3.x | Gestion des images |
| Intl | 0.19.x | Internationalisation |
| Hive | 2.2.x | Base de données locale |
| Riverpod | 2.4.x | État réactif (optionnel) |

---

## 📸 Captures d'Écran

### Écran 1 - Liste des Produits
<img width="540" height="1230" alt="image" src="https://github.com/user-attachments/assets/dcebd577-a7c6-453b-a8c7-ddb3a6bd1705" />


### Écran 2 - Détails du Produit
```

<img width="540" height="1230" alt="image" src="https://github.com/user-attachments/assets/fdebf94b-df17-44a6-8386-7c7f73288ef4" />

```

### Écran 3 - Panier d'Achat
```

<img width="1080" height="2460" alt="image" src="https://github.com/user-attachments/assets/61c25060-ea98-4b8e-9b63-54c0c73c9aee" />

---

## 🔧 Difficultés Rencontrées et Solutions

La principale difficulté lors du développement de cette version Flutter a été la **gestion de la réactivité de l'état** et la **synchronisation du panier** entre différents écrans de la navigation. Flutter's BuildContext et setState peuvent être délicats à gérer dans une architecture complexe. Nous avons résolu ce problème en implémentant **Provider pour la gestion centralisée de l'état**, ce qui a permis une propagation automatique des changements du panier à tous les widgets consommateurs. De plus, nous avons utilisé **Hive pour la persistance locale**, ce qui garantit que le panier reste intact même après la fermeture de l'application.

---
---

## 🔗 Version Alternative

Cette application est également disponible en **Kotlin/Jetpack Compose** :
👉 [Voir la version Android/Kotlin](https://github.com/paka-ops/android_tp)

---

## 🚀 Installation et Démarrage

```bash
# Cloner le projet
git clone https://github.com/paka-ops/flutter_tp.git
cd flutter_tp

# Récupérer les dépendances
flutter pub get

# Lancer sur un appareil/émulateur
flutter run
```

---

## 📝 Licence
Ce projet est fourni à titre éducatif.


