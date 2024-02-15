import 'package:beatfusion/common/theme.dart';
import 'package:flutter/material.dart';
Future<void> showTermOfUse(BuildContext context) async {

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: MyTheme().tertiaryColor,
                    title: const Text('Terms & Conditions'),
                    content: const SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last updated: January 18, 2024',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.',
                          ),
                          SizedBox(height: 10),
                          Text(
                            'We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.',
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Interpretation',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural',
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Definitions',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'For the purposes of this Privacy Policy:',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Account means a unique account created for You to access our Service or parts of our Service.',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Affiliate means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Application refers to BeatFusion, the software program provided by the Company.',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Company (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to BeatFusion.',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Country refers to: Kerala, India',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Device means any device that can access the Service such as a computer, a cellphone or a digital tablet.',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Personal Data is any information that relates to an identified or identifiable individual.',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Service refers to the Application.',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Service Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Usage Data refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.',
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Contact Us',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'mshabeel999@gmail.com',
                            style: TextStyle(fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close',style: TextStyle(color: MyTheme().primaryColor),),
                      ),
                    ],
                  );
        },
      );
    },
  );
}