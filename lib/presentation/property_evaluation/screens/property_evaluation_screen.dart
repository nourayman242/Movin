import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_injection/getIt/service_locator.dart';

import '../managers/poperty_evaluation_bloc/property_evaluation_bloc.dart';
import '../managers/poperty_evaluation_bloc/property_evaluation_state.dart';
import '../managers/poperty_evaluation_bloc/prpoerty_evaluation_event.dart';
import '../widgets/property_dropdown.dart';
import '../widgets/property_textfield.dart';
import '../widgets/result_card.dart';

class PropertyEvaluationScreen extends StatefulWidget {
  const PropertyEvaluationScreen({super.key});

  @override
  State<PropertyEvaluationScreen> createState() =>
      _PropertyEvaluationScreenState();
}

class _PropertyEvaluationScreenState extends State<PropertyEvaluationScreen> {
  final sizeController = TextEditingController();

  final bedroomsController = TextEditingController();

  final bathroomsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<PropertyEvaluationBloc>()..add(GetPropertyMetadataEvent()),

      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F7FA),
          elevation: 0,

          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF0B1F3A),
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          title: const Text(
            "Property Evaluation",
            style: TextStyle(
              color: Color(0xFF0B1F3A),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),

          centerTitle: false,
        ),

        body: BlocConsumer<PropertyEvaluationBloc, PropertyEvaluationState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent,

                  content: Text(state.error!),
                ),
              );
            }
          },

          builder: (context, state) {
            final bloc = context.read<PropertyEvaluationBloc>();

            if (state.loadingMetadata) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
              );
            }

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(28),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),

                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF0B1F3A), Colors.black],
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.14),

                            blurRadius: 25,

                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),

                      child: const Column(
                        children: [
                          Icon(
                            Icons.real_estate_agent_rounded,

                            size: 54,

                            color: Color(0xFFD4AF37),
                          ),

                          SizedBox(height: 16),

                          Text(
                            'AI Property Evaluation',

                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 26,

                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 12),

                          Text(
                            'Get accurate AI-powered property evaluation instantly.',

                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: Colors.white70,

                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    PropertyDropdown(
                      items: state.metadata?.propertyTypes ?? [],

                      value: state.selectedType,

                      hint: 'Select Property Type',

                      onChanged: (value) {
                        if (value != null) {
                          bloc.add(UpdatePropertyTypeEvent(value));
                        }
                      },
                    ),

                    const SizedBox(height: 18),

                    PropertyDropdown(
                      items: state.metadata?.areas.keys.toList() ?? [],

                      value: state.selectedMainArea,

                      hint: 'Select Main Area',

                      onChanged: (value) {
                        if (value != null) {
                          bloc.add(UpdateMainAreaEvent(value));
                        }
                      },
                    ),

                    const SizedBox(height: 18),

                    PropertyDropdown(
                      key: ValueKey(state.selectedMainArea),
                      items: state.subAreas,
                      //value: state.selectedSubArea,
                      value: state.subAreas.contains(state.selectedSubArea)
                          ? state.selectedSubArea
                          : null,
                      hint: 'Select Sub Area',

                      onChanged: (value) {
                        if (value != null) {
                          bloc.add(UpdateSubAreaEvent(value));
                        }
                      },
                    ),

                    const SizedBox(height: 18),

                    PropertyDropdown(
                      items: const ['Cash', 'Installments'],

                      value: state.selectedPayment,

                      hint: 'Payment Method',

                      onChanged: (value) {
                        if (value != null) {
                          bloc.add(UpdatePaymentEvent(value));
                        }
                      },
                    ),

                    const SizedBox(height: 18),

                    PropertyTextField(
                      controller: sizeController,

                      hint: 'Size (sqm)',

                      number: true,
                    ),

                    const SizedBox(height: 18),

                    PropertyTextField(
                      controller: bedroomsController,

                      hint: 'Bedrooms',

                      number: true,
                    ),

                    const SizedBox(height: 18),

                    PropertyTextField(
                      controller: bathroomsController,

                      hint: 'Bathrooms',

                      number: true,
                    ),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,

                      height: 60,

                      child: ElevatedButton(
                        onPressed: state.loadingPrediction
                            ? null
                            : () {
                                if (sizeController.text.isEmpty ||
                                    bedroomsController.text.isEmpty ||
                                    bathroomsController.text.isEmpty ||
                                    state.selectedType == null ||
                                    state.selectedMainArea == null ||
                                    state.selectedPayment == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please fill all required fields',
                                      ),
                                    ),
                                  );

                                  return;
                                }

                                bloc.add(
                                  PredictPropertyPriceEvent(
                                    size: sizeController.text,

                                    bedrooms: bedroomsController.text,

                                    bathrooms: bathroomsController.text,
                                  ),
                                );
                              },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0B1F3A),

                          elevation: 0,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),

                        child: state.loadingPrediction
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Evaluate Property',

                                style: TextStyle(
                                  color: Colors.white,

                                  fontSize: 18,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    if (state.predictedPrice != null)
                      ResultCard(price: state.predictedPrice!),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
