import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/Property_detials/cubit/report_cubit.dart';
import 'package:movin/presentation/Property_detials/cubit/report_state.dart';

class ReportScreen extends StatefulWidget {
  final String propertyId;
  final String sellerId;

  const ReportScreen({
    super.key,
    required this.propertyId,
    required this.sellerId,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  String selectedTarget = "Property";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportCubit, ReportState>(
      listener: (context, state) {
        if (state is ReportSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.navyDark,
            ),
          );
          Navigator.pop(context);
        }

        if (state is ReportError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.primaryNavy,
            title: Text(
              selectedTarget == "User" ? "Report Seller" : "Report Property",
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryNavy.withOpacity(.05),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.report_gmailerrorred,
                        size: 70,
                        color: AppColors.gold,
                      ),
                      const SizedBox(height: 15),

                      Text(
                        "Submit a Report",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navyDark,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Help us keep Movin safe by reporting suspicious sellers or fake properties.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),

                      const SizedBox(height: 25),
                      DropdownButtonFormField<String>(
                        dropdownColor: AppColors.white,
                        value: selectedTarget,
                        decoration: AppInputDecoration.rounded(
                          hintText: "Select Report Target",
                          prefixIcon: Icons.flag_outlined,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Property",
                            child: Text("Report Property"),
                          ),
                          DropdownMenuItem(
                            value: "User",
                            child: Text("Report Seller"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedTarget = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 18),

                      TextField(
                        controller: subjectController,
                        decoration: AppInputDecoration.rounded(
                          hintText: "Report Subject",
                          prefixIcon: Icons.title,
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: messageController,
                        maxLines: 5,
                        decoration: AppInputDecoration.rounded(
                          hintText: "Describe the issue...",
                          //prefixIcon: Icons.message_outlined,
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: AppButtons.primary,
                          onPressed: state is ReportLoading
                              ? null
                              : () {
                                  context.read<ReportCubit>().createReport(
                                    subject: subjectController.text.trim(),
                                    message: messageController.text.trim(),
                                    targetType: selectedTarget,
                                    targetId: selectedTarget == "User"
                                        ? widget.sellerId
                                        : widget.propertyId,
                                  );
                                },
                          icon: state is ReportLoading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.send, color: Colors.white),
                          label: Text(
                            state is ReportLoading
                                ? "Submitting..."
                                : "Submit Report",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
