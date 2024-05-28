import 'package:xcmobile/features/4-activation/models/activation_method_model.dart';
import 'package:xcmobile/features/4-activation/models/activation_offer_model.dart';

final activationMethods = [
  ActivationMethodModel(id: 1, image: "assets/logos/cin.png", title: "CIN",description:"Carte d’Identité Nationale" ),
  ActivationMethodModel(id: 2, image: "assets/logos/sejour.png", title: "Carte de Séjour",description:"Carte de Séjour"),
  ActivationMethodModel(id: 3, image: "assets/logos/passport.png", title: "Passeport",description:"Passeport"),
];

int cinIndex = 1;
int sejourIndex = 2;
int passportIndex = 3;


final activationOffers = [
  ActivationOfferModel(id: 1, title: "Pass Etudiant",description:"Pass Etudiant" ),
  ActivationOfferModel(id: 2, title: "Offre PO9",description:"Offre PO9"),
  ActivationOfferModel(id: 3, title: "Offre Aziza",description:"Offre Aziza"),
  ActivationOfferModel(id: 4, title: "Offre Taraji",description:"Offre Taraji"),
  ActivationOfferModel(id: 5, title: "Offre Spéciale",description:"Offre Spéciale"),
];


final activationNumbers = [
  "99244221",
  "99244222",
  "92442413",
  "92442414"
];

