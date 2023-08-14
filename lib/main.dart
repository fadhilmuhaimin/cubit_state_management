import 'package:cubit_state_management/bloc/bloc/counter_bloc.dart';
import 'package:cubit_state_management/cubit/countercubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CounterBloc()),
            BlocProvider(create: (context) => CountercubitCubit())
          ],
          child: MainPage(),
        ));
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    CounterBloc bloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                color: Colors.black,
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bloc State Management",
                      style: GoogleFonts.poppins(
                          fontSize: 25, color: Colors.white),
                    ),
                    BlocBuilder<CounterBloc, CounterState>(
                      builder: (_, state) {
                        return Text(
                            (state is CounterBlocState)
                                ? "${state.value}"
                                : "-",
                            style: GoogleFonts.poppins(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                color: Colors.white));
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(CounterBlocIncrement(1));
                        },
                        child: Text(
                          "+",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ))
                  ],
                ),
              )),
          Flexible(
              flex: 1,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cubit State Management",
                      style: GoogleFonts.poppins(fontSize: 25),
                    ),
                    BlocBuilder<CountercubitCubit, CountercubitState>(
                      builder: (_, state) {
                        return Text((state is CountercubitStateFilled)
                        ? "${state.value}"
                        : "-",
                            style: GoogleFonts.poppins(
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                            ));
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<CountercubitCubit>().cubitIncrement(1);
                        },
                        child: Text(
                          "+",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
