import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/generated/assets.gen.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_colors.dart';

@RoutePage()
class AddDevicePage extends StatelessWidget {
  const AddDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Add a device',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FC),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(Assets.images.svg.scan),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
                children: [
                  DeviceCard(
                    image: Assets.images.png.watch1.image(),
                    name: 'Cardoo Watch',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  DeviceCard(
                    image: Assets.images.png.buds.image(),
                    name: 'Cardoo Buds',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  DeviceCard(
                    image: Assets.images.png.ring.image(),
                    name: 'Cardoo Ring',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  DeviceCard(
                    image: Assets.images.png.watch2.image(),
                    name: 'Cardoo Watch',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  DeviceCard(
                    image: Assets.images.png.headPhone.image(),
                    name: 'Cardoo Headphone',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            // Home Indicator (iOS style)
            Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 8),
              child: Container(
                width: 120,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFF122858),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final Widget image;
  final String name;
  final VoidCallback onTap;
  const DeviceCard({
    super.key,
    required this.image,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF9F9FC),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
        child: Row(
          children: [
            image,
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
