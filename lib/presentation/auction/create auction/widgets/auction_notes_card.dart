import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuctionNotesCard extends StatelessWidget {
  const AuctionNotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Important Notes", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("• All auction details will be reviewed by admin before going live"),
          Text("• Make sure auction times are set correctly (timezone: UAE Time)"),
          Text("• Starting bid should be reasonable and competitive"),
          Text("• You'll be notified once the auction is approved and live"),
          Text("• Auction cannot be cancelled once bidding has started"),
        ],
      ),
    );
  }
}