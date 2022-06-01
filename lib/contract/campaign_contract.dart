import '../model/campaign.dart';
import '../model/product.dart';

import 'package:flutter/material.dart';

abstract class CampaignContract {

  void onAllCampaignOfferFound(List<Campaign> campaigns);
  void onFailedToGetCampaignOffers(BuildContext context);
  void onCampaignDataFound(Campaign campaign);
  void onFailedToGetCampaignData(BuildContext context);
}