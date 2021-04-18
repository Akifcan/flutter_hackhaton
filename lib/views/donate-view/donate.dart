import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:help_together/dto/donate.dto.dart';
import 'package:help_together/core/string_extensions.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  String cardNumber = '', expiryDate = '', cardHolderName = '', cvvCode = '';

  bool isCvvFocused = true;

  @override
  Widget build(BuildContext context) {
    final DonateDto args =
        ModalRoute.of(context).settings.arguments as DonateDto;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title.capitalize),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.info),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (_) => Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Bağış Hakkında',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontWeight: FontWeight.bold)),
                        Text('Toplam Hedef: ${args.goal} ₺',
                            style: Theme.of(context).textTheme.headline5),
                        Text(args.description.capitalize,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ));
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [_creditCard, _donateForm, _donateButton],
          ),
        ),
      ),
    );
  }

  Widget get _creditCard => CreditCardWidget(
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cardHolderName: cardHolderName,
        cvvCode: cvvCode,
        showBackView: false, //true when you want to show cvv(back) view
      );

  Widget get _donateForm => CreditCardForm(
        formKey: GlobalKey<FormState>(), // Required
        onCreditCardModelChange: (CreditCardModel data) {}, // Required
        themeColor: Colors.red,
        obscureCvv: true,
        obscureNumber: true,
        cardNumberDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Number',
          hintText: 'XXXX XXXX XXXX XXXX',
        ),
        expiryDateDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Expired Date',
          hintText: 'XX/XX',
        ),
        cvvCodeDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'CVV',
          hintText: 'XXX',
        ),
        cardHolderDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Card Holder',
        ),
        cardHolderName: cardHolderName,
        cardNumber: cardNumber,
        cvvCode: cvvCode,
        expiryDate: expiryDate,
      );

  Widget get _donateButton => Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('Bağış Yap'),
          ),
          onPressed: () {},
        ),
      );
}
