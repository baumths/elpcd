import '../entities/entities.dart';

abstract class IDatabaseRepository {
  Classe getEntryById(int id);
  List<Classe> getAllEntries();
  void insert(Classe classe);
  void delete(Classe classe);
}
