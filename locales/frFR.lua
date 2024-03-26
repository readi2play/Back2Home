local _, b2h = ...

b2h.L = b2h.L or {}
b2h.L.frFR = {
  -- generic strings
  ["resetBtnLbl"] = "Réinitialiser",
  ["unselectAllBtnLbl"] = "Tout déselectionner",
  ["selectAllBtnLbl"] = "Tout selectionner",
  ["button"] = "Bouton",
  ["toyNotCollected"] = "Vous n'avez pas encore récupéré ce jouet.",
  ["debugging"] = "Debugging",
  -- config panel titles
  ["toysAndFallbackPanelTitle"] = "Jouets et solutions de secours",
  ["frameSettingsPanelTitle"] = "Paramètres du cadre",
  ["keybindingSettingsPanelTitle"] = "Raccourcis clavier",
  ["otherSettingsPanelTitle"] = "Autres paramètres",
  -- reporting strings
  ["reportInit"] = "Bouton initialiser...",
  ["reportTooltip"] = "Info-bulle d'écriture...",
  ["reportIcon"] = "Peindre l'icône...",
  ["reportButton"] = "Mise à jour de l'action du bouton...",
  ["reportShuffle"] = "Rassembler des données ...",
  -- info panel strings
  ["infoAddonVersion"] = "Version:",
  ["infoAddonAuthor"] = "Auteur:",
  ["infoTextHeadline"] = "Commandes barre oblique",
  ["infoText1"] = "Mélangez vos jouets Hearthstone. Soit en cliquant avec le bouton droit sur le bouton",
  ["infoText2"] = "soit en utilisant l'une des commandes slash suivantes",
  ["infoText3"] = "ou alors",
  ["infoText4"] = "Ouvrez ce panneau de configuration pour ajuster les jouets Hearthstone à utiliser par le bouton",
  ["infoText5"] = "le cadre auquel le bouton est ancré et si l'élément Hearthstone standard doit être utilisé comme solution de secours s'il n'y a pas encore de jouets Hearthstone collectés.",
  ["infoText6"] = "Merci d'avoir utilisé",
  ["infoText7"] = "et reste en bonne santé",
  ["infoText8"] = "Cordialement",
  -- toys & fallback panel strings
  ["toysHeadline"] = "Jouets Hearthstone inclus",
  ["toysSubHeadline"] = "(Les cases à cocher pour les jouets non encore collectés sont désactivées)",
  ["fallbackText"] = "Cet objet sera utilisé comme solution de secours si aucun jouet Hearthstone n'est collecté ou sélectionné.",
  -- frame anchoring panel strings
  ["btnAnchor1"] = "Sélectionnez le point d'ancrage du bouton",
  ["btnAnchor2"] = "qui doit être aligné sur son cadre parent.",
  ["parentAnchorHeadline"] = "Ancrage du cadre parent",
  ["parentAnchor1"] = "Sélectionnez le point d'ancrage du cadre parent auquel le bouton",
  ["parentAnchor2"] = "doit être ancré.",
  ["offsetHeadline"] = "Décalage de position",
  ["offsetX"] = "Décalage X",
  ["offsetY"] = "Décalage Y",
  ["parentFrameHeadline"] = "Cadre parent",
  ["parentFrameName"] = "Entrez le nom du cadre parent",
  ["buttonSizeSliderHeadline"] = "Taille du bouton",
  -- keybinding panel strings
  ["keybindingSectionSubtext1"] = "Sélectionnez une touche de modification pour utiliser facilement votre",
  ["keybindingSectionSubtext2"] = "via",
  -- debugging
  ["allDebugging"] = "Activer tous les rapports de débogage",
  ["generalDebugging"] = "Activer les rapports de débogage généraux",
  ["toysDebugging"] = "Activer les rapports de débogage pour les jouets",
  ["positioningDebugging"] = "Activer les rapports de débogage pour le positionnement",
  ["keybindingsDebugging"] = "Activer les rapports de débogage pour les raccourcis clavier",
}