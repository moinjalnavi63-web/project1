import 'package:flutter/material.dart';

class BusFormDialog extends StatefulWidget {
  final Map<String, dynamic>? bus;

  const BusFormDialog({
    super.key,
    this.bus,
  });

  @override
  State<BusFormDialog> createState() => _BusFormDialogState();
}

class _BusFormDialogState extends State<BusFormDialog> {
  late TextEditingController busNumberController;
  late TextEditingController registrationController;
  late TextEditingController driverNameController;
  late TextEditingController driverMobileController;
  late TextEditingController routeController;
  late TextEditingController pickupTimeController;
  late TextEditingController departureTimeController;
  late TextEditingController arrivalTimeController;

  @override
  void initState() {
    super.initState();

    final bus = widget.bus;

    final driver = bus?['driver'] as Map<String, dynamic>?;

    busNumberController = TextEditingController(
      text: bus?['busNumber'] ?? '',
    );

    registrationController = TextEditingController(
      text: bus?['registrationNumber'] ?? '',
    );

    driverNameController = TextEditingController(
      text: driver?['name'] ?? '',
    );

    driverMobileController = TextEditingController(
      text: driver?['mobile'] ?? '',
    );

    routeController = TextEditingController(
      text: bus?['route'] ?? '',
    );

    pickupTimeController = TextEditingController(
      text: bus?['pickupTime'] ?? '',
    );

    departureTimeController = TextEditingController(
      text: bus?['departureTime'] ?? '',
    );

    arrivalTimeController = TextEditingController(
      text: bus?['arrivalTime'] ?? '',
    );
  }

  @override
  void dispose() {
    busNumberController.dispose();
    registrationController.dispose();
    driverNameController.dispose();
    driverMobileController.dispose();
    routeController.dispose();
    pickupTimeController.dispose();
    departureTimeController.dispose();
    arrivalTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.bus != null;

    return AlertDialog(
      title: Text(
        isEditing ? 'Edit Bus' : 'Add Bus',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _field(
              controller: busNumberController,
              label: 'Bus Number',
              icon: Icons.directions_bus_outlined,
              hint: 'Bus 1',
            ),

            const SizedBox(height: 12),

            _field(
              controller: registrationController,
              label: 'Registration Number',
              icon: Icons.badge_outlined,
              hint: 'KA 35 AB 1234',
            ),

            const SizedBox(height: 12),

            _field(
              controller: driverNameController,
              label: 'Driver Name',
              icon: Icons.person_outline,
              hint: 'Driver name',
            ),

            const SizedBox(height: 12),

            _field(
              controller: driverMobileController,
              label: 'Driver Mobile',
              icon: Icons.phone_outlined,
              hint: 'Mobile number',
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 12),

            _field(
              controller: routeController,
              label: 'Route',
              icon: Icons.route_outlined,
              hint: 'Hospet → Kishkinda University',
            ),

            const SizedBox(height: 12),

            _field(
              controller: pickupTimeController,
              label: 'Pickup Time',
              icon: Icons.access_time_outlined,
              hint: '07:30 AM',
            ),

            const SizedBox(height: 12),

            _field(
              controller: departureTimeController,
              label: 'Departure Time',
              icon: Icons.departure_board_outlined,
              hint: '08:00 AM',
            ),

            const SizedBox(height: 12),

            _field(
              controller: arrivalTimeController,
              label: 'Arrival Time',
              icon: Icons.access_time_filled_outlined,
              hint: '09:00 AM',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: () {
            if (busNumberController.text.trim().isEmpty) {
              return;
            }

            Navigator.pop(
              context,
              {
                'busNumber':
                busNumberController.text.trim(),

                'registrationNumber':
                registrationController.text.trim(),

                'driver': {
                  'name':
                  driverNameController.text.trim(),

                  'mobile':
                  driverMobileController.text.trim(),
                },

                'route':
                routeController.text.trim(),

                'pickupTime':
                pickupTimeController.text.trim(),

                'departureTime':
                departureTimeController.text.trim(),

                'arrivalTime':
                arrivalTimeController.text.trim(),

                'stops':
                widget.bus?['stops'] ??
                    <Map<String, String>>[],
              },
            );
          },
          child: Text(
            isEditing ? 'Save Changes' : 'Add Bus',
          ),
        ),
      ],
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}