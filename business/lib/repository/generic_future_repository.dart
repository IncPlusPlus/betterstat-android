/// This class aims to resemble
/// `org.springframework.data.repository.CrudRepository` without actually
/// being a data store. Instead, an API will be used.
abstract class GenericFutureRepository<T, ID> {
  Future<T> createById(T schedule);

  Future<T> deleteById(ID id);

  Future<T> getById(ID id);

  Future<List<T>> getAll();

  Future<T> saveById(T schedule, ID id);
}
