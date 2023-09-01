import 'package:postgres/postgres.dart';

class StoreData {
  static saveData() async {
    var connection = PostgreSQLConnection(
      "localhost",
      5432,
      "flutter_sql_test",
      username: "postgres",
      password: "Liomessi10",
      useSSL: true,
    );
    print("Opening connection...");
    try {
      await connection.open();
    } catch (e) {
      print("EXCEPTIONNNNNN: ${e}");
    }
    // await connection.transaction((ctx) async {
    //   print("Executing transaction...");
    //   await ctx.query("INSERT INTO table (id) VALUES (@name:character varying)",
    //       substitutionValues: {"a": "Clark"});
    //   print("Transaction executed successfully!");
    // });
    //
    // print("Closing connection...");
    // await connection.close();
    // print("Connection closed.");
  }
}
