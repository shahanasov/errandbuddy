// import 'package:flutter/material.dart';

// class ProfileAvatarWidget extends StatelessWidget {
//   final String imageUrl;
//   final double size;
//   final Color backgroundColor;
//   final double borderWidth;
//   final Color borderColor;
//   final VoidCallback? onTap;

//   const ProfileAvatarWidget({
//     super.key,
//     required this.imageUrl,
//     this.size = 120.0,
//     this.backgroundColor = const Color(0xFFF5E6D3),
//     this.borderWidth = 0.0,
//     this.borderColor = Colors.transparent,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: size,
//         height: size,
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           shape: BoxShape.circle,
//           border: borderWidth > 0
//               ? Border.all(color: borderColor, width: borderWidth)
//               : null,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black,
//               blurRadius: 10,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: ClipOval(
//           child: Stack(
//             children: [
//               // Background color
//               Container(
//                 width: size,
//                 height: size,
//                 color: backgroundColor,
//               ),
//               // Profile image
//               Center(
//                 child: Image.network(
//                   imageUrl,
//                   width: size * 0.85, // Slightly smaller than container
//                   height: size * 0.85,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       width: size * 0.85,
//                       height: size * 0.85,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.person,
//                         size: size * 0.4,
//                         color: Colors.grey[600],
//                       ),
//                     );
//                   },
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Container(
//                       width: size * 0.85,
//                       height: size * 0.85,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             Colors.grey[400]!,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Custom widget for displaying multiple profile avatars in a row
// class ProfileAvatarRow extends StatelessWidget {
//   final List<ProfileAvatarData> avatars;
//   final double spacing;
//   final double avatarSize;

//   const ProfileAvatarRow({
//     super.key,
//     required this.avatars,
//     this.spacing = 20.0,
//     this.avatarSize = 120.0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: avatars
//           .map((avatar) => ProfileAvatarWidget(
//                 imageUrl: avatar.imageUrl,
//                 size: avatarSize,
//                 backgroundColor: avatar.backgroundColor,
//                 borderWidth: avatar.borderWidth,
//                 borderColor: avatar.borderColor,
//                 onTap: avatar.onTap,
//               ))
//           .toList(),
//     );
//   }
// }

// // Data class for profile avatar information
// class ProfileAvatarData {
//   final String imageUrl;
//   final Color backgroundColor;
//   final double borderWidth;
//   final Color borderColor;
//   final VoidCallback? onTap;

//   ProfileAvatarData({
//     required this.imageUrl,
//     this.backgroundColor = const Color(0xFFF5E6D3),
//     this.borderWidth = 0.0,
//     this.borderColor = Colors.transparent,
//     this.onTap,
//   });
// }

// // Example usage widget
// class ProfileAvatarExample extends StatelessWidget {
//   const ProfileAvatarExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<ProfileAvatarData> sampleAvatars = [
//       ProfileAvatarData(
//         imageUrl: 'https://example.com/woman-profile.jpg',
//         backgroundColor: const Color(0xFFF5E6D3),
//         onTap: () => print('Tapped woman profile'),
//       ),
//       ProfileAvatarData(
//         imageUrl: 'https://example.com/man-profile1.jpg',
//         backgroundColor: const Color(0xFFE8D5C4),
//         onTap: () => print('Tapped man profile 1'),
//       ),
//       ProfileAvatarData(
//         imageUrl: 'https://example.com/man-profile2.jpg',
//         backgroundColor: const Color(0xFFDDC3A9),
//         onTap: () => print('Tapped man profile 2'),
//       ),
//     ];

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text('Profile Avatars'),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Profile Avatars',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               ProfileAvatarRow(
//                 avatars: sampleAvatars,
//                 avatarSize: 120,
//                 spacing: 20,
//               ),
//               const SizedBox(height: 40),
//               // Example of individual avatar with different styling
//               ProfileAvatarWidget(
//                 imageUrl: 'https://example.com/sample-profile.jpg',
//                 size: 150,
//                 backgroundColor: const Color(0xFFF0F8FF),
//                 borderWidth: 3,
//                 borderColor: Colors.blue,
//                 onTap: () => print('Tapped large avatar'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }