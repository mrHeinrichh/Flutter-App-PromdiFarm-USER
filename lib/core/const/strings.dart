// ignore_for_file: non_constant_identifier_names
import 'package:flutter_dotenv/flutter_dotenv.dart';

String TOKEN = dotenv.get('TOKEN_NAME', fallback: 'promdi_token');
String CDN = dotenv.get('CDN', fallback: '');
String PROJECT_NAME = dotenv.get('PROJECT_NAME', fallback: '');

class GOOGLE {
  static const String DIRECTION_API =
      "https://maps.googleapis.com/maps/api/directions/json?";

  static String get KEY {
    return dotenv.get('GOOGLE_KEY', fallback: '');
  }
}

class ICON {
  static String get STATUS {
    return CDN + "icons/png/status.png";
  }

  static String get DELIVERIES {
    return CDN + "icons/png/deliveries.png";
  }

  static String get GREEN_PENCIL {
    return CDN + "icons/png/green-pencil.png";
  }

  static String get MAP {
    return CDN + "icons/png/map.png";
  }

  static String get HISTORY {
    return CDN + "icons/png/history.png";
  }

  static String get HOME {
    return CDN + "icons/png/home.png";
  }

  static String get PROFILE {
    return CDN + "icons/png/profile.png";
  }

  static String get CALENDAR {
    return CDN + "icons/png/calendar.png";
  }

  static String get WALLET {
    return CDN + "icons/png/wallet.png";
  }

  static String get HELP {
    return CDN + "icons/png/help.png";
  }

  static String get FEEDBACK {
    return CDN + "icons/png/feedback.png";
  }

  static String get INVITE_FRIENDS {
    return CDN + "icons/png/invite-friends.png";
  }

  static String get SETTINGS {
    return CDN + "icons/png/settings.png";
  }

  static String get LOGOUT {
    return CDN + "icons/png/logout.png";
  }

  static String get RIDER {
    return CDN + "icons/png/rider.png";
  }

  static String get OUTLET {
    return CDN + "icons/png/outlet.png";
  }

  static String get DROPOFF {
    return CDN + "icons/png/dropoff.png";
  }
}

class IMAGE {
  static String get FEMALE {
    return CDN + "images/png/people/female.png";
  }

  static String get EMPTY_PENDING_DELIVERY {
    return CDN + "images/png/delivery/empty_pending_delivery.png";
  }

  static String get EMPTY_FAILED_DELIVERY {
    return CDN + "images/png/delivery/empty_failed_delivery.png";
  }

  static String get EMPTY_COMPLETED_DELIVERY {
    return CDN + "images/png/delivery/empty_completed_delivery.png";
  }

  static String get OFFLINE {
    return CDN + "icons/png/offline.png";
  }

  static String get ONLINE {
    return CDN + "icons/png/logo-m.png";
  }
}

const String GOOGLE_PLAY = "Google Play Services";

const String TERMS_CONDITION_1 =
    "By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. \n\nThe app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Yahu. Yahu is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.\n\nThe Yahu app stores and processes personal data that you have provided to us, to provide our Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Yahu app won’t work properly or at all. \n\nThe app does use third-party services that declare their Terms and Conditions. Link to Terms and Conditions of third-party service providers used by the app ";

const String TERMS_CONDITION_2 =
    "You should be aware that there are certain things that Yahu will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but Yahu cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.If you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. \n\nAs a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming.\n\n If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app. Along the same lines, Yahu cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Yahu cannot accept responsibility.\n\n With respect to Yahu’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Yahu accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app. At some point, we may wish to update the app. \n\nThe app is currently available on Android & iOS – the requirements for the both systems(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Yahu does not promise that it will always update the app so that it is relevant to you and/or works with the Android & iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.";

class TITLE {
  static String get SORRY {
    return "We are sorry!!!";
  }

  static String get GOOGLE_PLAY {
    return "Google Play Services";
  }

  static String get PRIVACY_INTRODUCTION {
    return "DitoSoft Technologies built the Yahu app as a Commercial app. This SERVICE is provided by Yahu and is intended for use as is.This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Yahu unless otherwise defined in this Privacy Policy. Information Collection and Use For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to License, ORCR, Location. The information that we request will be retained by us and used as described in this privacy policy.The app does use third-party services that may collect information used to identify you. \n\nLink to the privacy policy of third-party service providers used by the app.";
  }

  static String get LOG_DATA {
    return "Log Data";
  }

  static String get COOKIES {
    return "Cookies";
  }

  static String get SERVICE_PROVIDERS {
    return "Service Providers";
  }

  static String get SECURITY {
    return "Security";
  }

  static String get LINKS {
    return "Links to Other Sites";
  }

  static String get CHILD_PRIVACY {
    return "Children's Privacy";
  }

  static String get BULLET_TEXT {
    return "\n•	To facilitate our Service;\n•	To provide the Service on our behalf; \n•	To perform Service-related services; or \n•	To assist us in analyzing how our Service is used.";
  }

  static String get LOG_DATA_CONTENT {
    return "\nWe want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.\n";
  }

  static String get COOKIES_CONTENT {
    return "\nCookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory. \n \nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service. \n";
  }

  static String get SERVICE_PROVIDERS_CONTENTS {
    return "\nWe want to inform users of this Service that these third parties have access to their Personal Information.\n\nThe reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.";
  }

  static String get SERVICE_PROVIDERS_CONTENTS_2 {
    return "\nWe want to inform users of this Service that these third parties have access to their Personal Information.\n\nThe reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.\n ";
  }

  static String get SECURITY_CONTENTS {
    return "\nWe value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.\n";
  }

  static String get LINKS_CONTENT {
    return "\nThis Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services. \n";
  }

  static String get CHILD_PRIVACY_CONTENTS {
    return "\nThese Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do the necessary actions.";
  }
}

class ROUTE {
  static const String HOME = "home";
  static const String HOME_BACK = "home-back";
  static const String DELIVERIES = "deliveries";
  static const String MAP = "map";
  static const String HISTORY = "history";
  static const String LOGIN = "login";
  static const String SIGN_UP = "sign-up";
  static const String FORGET_PW = "forget-password";
  static const String WALLET = "wallet";
  static const String PROFILE = "rider-profile";
  static const String RIDER_PASSWORD = "rider-password";
  static const String RIDER_DELIVERIES = "rider-deliveries";
  static const String HELP_CENTER = "help-centre";
  static const String FEEDBACK = "feedback";
  static const String TRANSACTION = "delivery-transaction";
  static const String TERMS_PRIVACY = "terms-condition-privacy";
  static const String TERMS_PRIVACY_BACK = "terms-condition-privacy-back";
  static const String SETTINGS = "settings";
  static const String INVITE = "invite-friends";
  static const String DESTINATION = "destination";
  static const String DESTINATION_STATUS = "destination-status";
  static const String DESTINATION_COMPLETED = "destination-status-completed";
  static const String DESTINATION_FAILED = "destination-status-failed";
  static const String SUCCESS = "success";
  static const String TERMS_CONDITION = "terms-condition";
  static const String PRIVACY = "privacy";
  static const String EDITPROFILE = "edit-profile";
}
