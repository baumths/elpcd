import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:elpcd_dart/src/managers/managers.dart';
import 'package:elpcd_dart/src/utils/utils.dart';

part 'form/custom_widgets.dart';
part 'form/required_fields.dart';
part 'form/additional_fields.dart';
part 'form/ttd_fields.dart';

class DescriptionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DescriptionManager>(
      builder: (_, manager, __) => Form(
        key: manager.formKey,
        child: Scrollbar(
          radius: const Radius.circular(24),
          controller: manager.scrollController,
          thickness: 8,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 128),
            physics: const BouncingScrollPhysics(),
            controller: manager.scrollController,
            child: Column(
              children: [
                if (manager.isSaving) const LinearProgressIndicator(),
                if (manager.pcd.codigo != null) _DescriptionTile(),
                RequiredFields(manager),
                AdditionalFields(manager),
                TTDFields(manager),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DescriptionTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final manager = context.watch<DescriptionManager>();
    return Hero(
      tag: '${manager.pcd.legacyId}',
      child: Material(
        child: ListTile(
          title: const Text('Subordinação'),
          subtitle: Text(
            manager.pcd.identifier,
            style: TextStyle(
              color: context.accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
