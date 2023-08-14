import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<CounterEvent>((event, emit) {
      if(event is CounterBlocIncrement){
        (state is CounterInitial) 
          ? emit(CounterBlocState(0)) 
          : emit(CounterBlocState((state as CounterBlocState).value + event.value));
        
      }
    });
  }
}
