import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/core/const/strings.dart';
import 'package:promdifarm_app/core/di/index.dart';
import 'package:promdifarm_app/view/bloc/deliveries/deliveries.cubit.dart';
import 'package:promdifarm_app/view/bloc/delivery_proof/delivery_proof.cubit.dart';
import 'package:promdifarm_app/view/bloc/destination_details/destination_details.cubit.dart';
import 'package:promdifarm_app/view/bloc/home/home.cubit.dart';
import 'package:promdifarm_app/view/bloc/slider/slider.cubit.dart';
import 'package:promdifarm_app/view/pages/deliveries.page.dart';
import 'package:promdifarm_app/view/widgets/destinations/completed/completed_list.dart';
import 'package:promdifarm_app/view/widgets/destinations/destination_details.dart';
import 'package:promdifarm_app/view/widgets/destinations/destination_tab_list.page.dart';
import 'package:promdifarm_app/view/widgets/destinations/failed/failed_list.dart';
import 'package:promdifarm_app/view/widgets/destinations/pickup/pickup_list.dart';
import 'package:promdifarm_app/view/widgets/destinations/proof_consignee/proof_consignee_list.dart';
import 'package:promdifarm_app/view/widgets/destinations/tabs/empty_tab.widget.dart';
import 'package:promdifarm_app/view/widgets/modal.widget.dart';
import 'package:promdifarm_app/view/widgets/drawer/side_nav.widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SliderCubit>(
            create: (BuildContext context) => sl<SliderCubit>(),
          ),
          BlocProvider<HomeCubit>(
            create: (BuildContext context) => sl<HomeCubit>(),
          ),
          BlocProvider<DeliveriesCubit>(
            create: (BuildContext context) => sl<DeliveriesCubit>(),
          ),
          BlocProvider<DestinationDetailsCubit>(
            create: (BuildContext context) => sl<DestinationDetailsCubit>(),
          ),
          BlocProvider<DeliveryProofCubit>(
            create: (BuildContext context) => sl<DeliveryProofCubit>(),
          ),
        ],
        child: Scaffold(
          backgroundColor: NEUTRAL_PRIMARY_ACCENT,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                Widget backButton = Container();

                if (state.backButton) {
                  backButton = GestureDetector(
                    onTap: () {
                      BlocProvider.of<HomeCubit>(context).goto(state.route);
                    },
                    child: Icon(Icons.arrow_back_ios_new_rounded),
                  );
                }

                if (state.enableBack) {
                  return AppBar(
                    title: Text(state.title),
                    backgroundColor: DARK,
                    leading: backButton,
                    leadingWidth: state.width,
                  );
                }

                return AppBar(
                  title: Text(state.title),
                  backgroundColor: DARK,
                  leadingWidth: state.width,
                );
              },
            ),
          ),
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is AcceptDeliveryLoading) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext ctx) {
                        return LoadingModal(
                          title: "Accepting Delivery",
                          subtitle:
                              "Please wait while building your next deliveries...",
                        );
                      },
                    );
                  }

                  if (state is AcceptDeliverySuccess) {
                    Timer(Duration(seconds: 2), () {
                      Navigator.pop(context);
                    });
                  }
                },
                buildWhen: (previous, current) {
                  return !(current is StartedDelivery ||
                      current is ArrivedDestination);
                },
                builder: (context, state) {
                  if (state is GotoTabList) {
                    BlocProvider.of<HomeCubit>(context).acceptDelivery(
                      id: state.id,
                    );

                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is AcceptDeliveryLoading) {
                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is AcceptDeliverySuccess) {
                    return DestinationTabList(
                      acceptDelivery: state.acceptDelivery,
                    );
                  }

                  if (state is PendingDelivery) {
                    return DestinationTabList(
                      acceptDelivery: state.acceptDelivery,
                    );
                  }

                  if (state is DoneDelivery || state is FailedDelivery) {
                    BlocProvider.of<DestinationDetailsCubit>(context).reset();
                    BlocProvider.of<DeliveryProofCubit>(context).reset();
                  }

                  if (state is DoneDelivery) {
                    return DestinationTabList(
                      value: 1,
                      acceptDelivery: state.acceptDelivery,
                    );
                  }

                  if (state is FailedDelivery) {
                    return DestinationTabList(
                      value: 2,
                      acceptDelivery: state.acceptDelivery,
                    );
                  }

                  if (state is GotoDestination) {
                    return DestinationDetails(
                      state.destination,
                      started: state.started,
                      arrived: state.arrived,
                    );
                  }

                  if (state is GotoFailedDestination) {
                    return FailedList(state.destination);
                  }

                  if (state is CompletedDelivery) {
                    return CompletedList(state.destination);
                  }

                  if (state is ProofOfDelivery) {
                    return ProofConsigneeList(state.destination);
                  }

                  if (state is PickupDelivery) {
                    return PickUpList(state.destination);
                  }

                  return BlocBuilder<SliderCubit, SliderState>(
                    builder: (context, state) {
                      bool isOnline = state is SliderOnline;

                      if (isOnline) {
                        BlocProvider.of<DeliveriesCubit>(context).reset();
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SwitchListTile(
                            title: Row(
                              children: [
                                Text(
                                  "Delivery Status",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: DARK,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.only(left: 10),
                                  color: isOnline
                                      ? ACCENT
                                      : NEUTRAL_PRIMARY_NORMAL,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      (isOnline ? 'Online' : 'Offline'),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: TEXT_LIGHT,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            value: isOnline,
                            activeColor: DARK,
                            activeTrackColor: ACCENT,
                            inactiveThumbColor: NEUTRAL_PRIMARY_DARK,
                            inactiveTrackColor: NEUTRAL_SECONDARY_ACCENT,
                            onChanged: (bool value) {
                              isOnline
                                  ? BlocProvider.of<SliderCubit>(context)
                                      .offline()
                                  : BlocProvider.of<SliderCubit>(context)
                                      .online();
                            },
                          ),
                          isOnline
                              ? DeliveriesPage()
                              : Expanded(
                                  child: EmptyTab(
                                    imageUrl: IMAGE.OFFLINE,
                                    title: "Oops! You are offline.",
                                    titleSize: 25,
                                    subtitle:
                                        "Go online to receive upcoming deliveries and start your shift.",
                                  ),
                                ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          drawer: SideNav(),
        ),
      ),
    );
  }
}
