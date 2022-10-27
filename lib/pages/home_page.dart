import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mento/blocs/mento_bloc/mento_bloc.dart';
import 'package:mento/models/mento_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MentoBloc _newsBloc = MentoBloc();

  @override
  void initState() {
    _newsBloc.add(GetCovidList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mento List')),
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<MentoBloc, MentoState>(
          listener: (context, state) {
            if (state is MentoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<MentoBloc, MentoState>(
            builder: (context, state) {
              if (state is MentoInitial) {
                return _buildLoading();
              } else if (state is MentoLoading) {
                return _buildLoading();
              } else if (state is MentoLoaded) {
                return _buildCard(context, state.mentoModel);
              } else if (state is MentoError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, MentoModel model) {
    print('List:::: ${model.topicName!.length}');
    return ListView.builder(
      itemCount: model.topicName!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
              // child: Container(
              //   margin: EdgeInsets.all(8.0),
              //   child: Column(
              //     children: <Widget>[
              //       Text("Country: ${model.countries![index].country}"),
              //       Text(
              //           "Total Confirmed: ${model.countries![index].totalConfirmed}"),
              //       Text("Total Deaths: ${model.countries![index].totalDeaths}"),
              //       Text(
              //           "Total Recovered: ${model.countries![index].totalRecovered}"),
              //     ],
              //   ),
              // ),
              ),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
