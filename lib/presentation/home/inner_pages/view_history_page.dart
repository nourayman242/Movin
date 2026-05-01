import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/home/cubit/view_history_cubit.dart';
import 'package:movin/presentation/home/widgets/view_history_cards.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';

class ViewHistoryPage extends StatefulWidget {
  const ViewHistoryPage({super.key});

  @override
  State<ViewHistoryPage> createState() => _ViewHistoryPageState();
}

class _ViewHistoryPageState extends State<ViewHistoryPage> {
  final Color navy = const Color(0xFF001F3F);
  final Color offWhite = const Color(0xFFF8F8F8);

  late final ViewHistoryCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ViewHistoryCubit>();
    _cubit.loadViewHistory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.background,

        // ----------------------
        // CUSTOM APP BAR
        // ----------------------
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: AppBar(
            backgroundColor: offWhite,
            elevation: 0,
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
            flexibleSpace: Padding(
              padding:
                  const EdgeInsets.only(top: 60, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -------- Title Row --------
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back, color: navy, size: 28),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "View History",
                        style: TextStyle(
                          color: navy,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // -------- Clear All Button --------
                  BlocBuilder<ViewHistoryCubit, ViewHistoryState>(
                    builder: (context, state) {
                      if (state is ViewHistoryLoaded &&
                          state.properties.isNotEmpty) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () =>
                                context.read<ViewHistoryCubit>().clearHistory(),
                            child: const Text(
                              "Clear All",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        // -----------------------------
        // BODY
        // -----------------------------
        body: BlocBuilder<ViewHistoryCubit, ViewHistoryState>(
          builder: (context, state) {
            // ── Loading ──
            if (state is ViewHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // ── Error ──
            if (state is ViewHistoryError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _cubit.loadViewHistory(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            // ── Loaded ──
            if (state is ViewHistoryLoaded) {
              if (state.properties.isEmpty) {
                return const Center(
                  child: Text(
                    "No history available",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemCount: state.properties.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 18),
                  itemBuilder: (context, index) {
                    final property = state.properties[index];

                    return ViewHistoryCard(
                      property: property,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: getIt<PropertyCubit>(),
                              child: PropertyDetailsScreen(
                                propertyId: property.id,
                              ),
                            ),
                          ),
                        );
                        // Reload history after returning so newly
                        // viewed properties appear immediately
                        _cubit.loadViewHistory();
                      },
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}