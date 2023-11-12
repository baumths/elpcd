import '../../features/class.dart';
import '../../storage_facade.dart';
import 'classes_repository.dart';

class VirtualStorageFacade extends StorageFacade {
  late VirtualClassesRepository _classesRepository;

  @override
  Future<void> init() async {
    _classesRepository = VirtualClassesRepository();
  }

  @override
  ClassesRepository get classesRepository => _classesRepository;
}
