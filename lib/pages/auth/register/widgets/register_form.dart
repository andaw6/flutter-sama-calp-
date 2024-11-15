import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import 'package:wave_odc/shared/ui/custom_text_field.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
  });

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'code': TextEditingController(),
    'address': TextEditingController(),
    'cni': TextEditingController(),
  };
  bool _obscureCode = true;

  final List<Map<String, dynamic>> _fields = [
    {
      'key': 'name',
      'label': 'Nom complet',
      'icon': Icons.person_outline_rounded,
      'keyboardType': TextInputType.text,
      'validator': (String? value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre nom';
        }
        return null;
      },
    },
    {
      'key': 'phone',
      'label': 'Numéro de téléphone',
      'icon': Icons.phone_outlined,
      'keyboardType': TextInputType.phone,
      'inputFormatters': [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
      ],
      'prefixText': '+221 ',
      'validator': (String? value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre numéro de téléphone';
        }
        if (value.length != 9) {
          return 'Le numéro doit contenir 9 chiffres';
        }
        if (!['77', '78', '75', '70', '76'].contains(value.substring(0, 2))) {
          return 'Numéro de téléphone sénégalais invalide';
        }
        return null;
      },
    },
    {
      'key': 'email',
      'label': 'Email',
      'icon': Icons.email_outlined,
      'keyboardType': TextInputType.emailAddress,
      'validator': (String? value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Veuillez entrer un email valide';
        }
        return null;
      },
    },
    {
      'key': 'code',
      'label': 'Code (4 chiffres)',
      'icon': Icons.lock_outline_rounded,
      'keyboardType': TextInputType.number,
      'inputFormatters': [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      'obscureText': true,
      'validator': (String? value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre code';
        }
        if (value.length != 4) {
          return 'Le code doit contenir 4 chiffres';
        }
        return null;
      },
    },
    {
      'key': 'address',
      'label': 'Adresse',
      'icon': Icons.location_on_outlined,
      'keyboardType': TextInputType.text,
      'validator': (String? value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre adresse';
        }
        return null;
      },
    },
    {
      'key': 'cni',
      'label': 'Numéro CNI',
      'icon': Icons.credit_card_outlined,
      'keyboardType': TextInputType.number,
      'inputFormatters': [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(13),
      ],
      'validator': (String? value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre numéro de CNI';
        }
        if (value.length != 13) {
          return 'Le numéro de CNI doit contenir 13 chiffres';
        }
        return null;
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      duration: const Duration(milliseconds: 800),
      child: Card(
        elevation: 8,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: widget.backgroundColor,
          ),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: _fields.map((field) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomTextField(
                    controller: _controllers[field['key']]!,
                    label: field['label'] as String,
                    icon: field['icon'] as IconData,
                    primaryColor: widget.primaryColor,
                    secondaryColor: widget.secondaryColor,
                    keyboardType: field['keyboardType'] as TextInputType?,
                    prefixText: field['prefixText'] as String?,
                    inputFormatters:
                        field['inputFormatters'] as List<TextInputFormatter>?,
                    obscureText: field['key'] == 'code' ? _obscureCode : false,
                    suffixIcon: field['key'] == 'code'
                        ? IconButton(
                            icon: Icon(
                              _obscureCode
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: widget.primaryColor.withOpacity(0.7),
                            ),
                            onPressed: () =>
                                setState(() => _obscureCode = !_obscureCode),
                          )
                        : null,
                    validator: field['validator'] as String? Function(String?),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
