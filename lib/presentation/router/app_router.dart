import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/business_logic/cubit/riskRewardGraph/risk_reward_graph_cubit.dart';
import 'package:flutter_challenge/business_logic/cubit/optionsForm/option_form_cubit_cubit.dart';
import 'package:flutter_challenge/presentation/screens/OptionsRiskReward/option_risk_graph.dart';

class AppRouter {
  Route routeGeneration(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<OptionFormCubit>(
                      create: (context) => OptionFormCubit(),
                    ),
                    BlocProvider<VisibilityCubit>(
                      create: (context) => VisibilityCubit(),
                    ),
                    BlocProvider<RiskRewardGraphCubit>(
                      create: (context) => RiskRewardGraphCubit(),
                    )
                  ],
                  child: const OptionFormScreen(),
                ));

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const SizedBox(child: Text("404 Screen Not Found !!!")),
        );
    }
  }
}
