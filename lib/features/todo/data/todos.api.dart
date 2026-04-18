import 'package:dio/dio.dart';
import 'package:learn_api/features/todo/models/todo.dart';
import 'package:retrofit/retrofit.dart';

part 'todos.api.g.dart';

@RestApi()
abstract class TodosApi {
  factory TodosApi(Dio dio) = _TodosApi;

  @GET("/todos")
  Future<List<Todo>> getTodos();

  @POST("/todos")
  Future<Todo> createTodo(@Body() Map<String, dynamic> body);

  @PUT("/todos/{id}")
  Future<void> updateTodo(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("/todos/{id}")
  Future<void> deleteTodo(@Path("id") int id);
}
