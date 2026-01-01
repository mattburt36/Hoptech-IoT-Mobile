import 'package:flutter/material.dart';
import 'package:hoptech_iot_app/generated/l10n.dart';
import 'package:hoptech_iot_app/modules/device/provisioning/view/states/connection_state_row.dart';

class ProvisionSuccess extends StatelessWidget {
  const ProvisionSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConnectionStateRow(
          S.of(context).sendingWifiCredentials,
          inProgress: false,
        ),
        ConnectionStateRow(
          S.of(context).confirmingWifiConnection,
          inProgress: false,
        ),
        ConnectionStateRow(
          S.of(context).provisionedSuccessfully,
          inProgress: false,
        ),
      ],
    );
  }
}
