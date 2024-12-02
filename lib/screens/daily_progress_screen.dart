import 'package:flutter/material.dart';
import 'background_challenge_screen.dart';
import 'success_screen.dart';

class DailyProgressScreen extends StatefulWidget {
  @override
  _DailyProgressScreenState createState() => _DailyProgressScreenState();
}

class _DailyProgressScreenState extends State<DailyProgressScreen> {
  List<Map<String, dynamic>> tasks = [
    {"id": 1, "name": "Faça x, y, enquanto a, b, c.", "difficulty": "Fácil", "completed": false},
    {"id": 2, "name": "Faça x, y, enquanto a, b, c.", "difficulty": "Fácil", "completed": false},
    {"id": 3, "name": "Faça x, y, enquanto a, b, c.", "difficulty": "Fácil", "completed": false},
  ];

  // Função para marcar uma tarefa como concluída
  void markTaskAsCompleted(int index) {
    setState(() {
      tasks[index]["completed"] = true;

      // Verifica se todas as tarefas foram concluídas
      if (tasks.every((task) => task["completed"])) {
        Future.delayed(Duration(milliseconds: 800), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SuccessScreen()),
          );
        });
      }
    });
  }

  // Calcula o progresso com base nas tarefas concluídas
  double get progress {
    int completedTasks = tasks.where((task) => task["completed"]).length;
    return completedTasks / tasks.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Desafios"),
        backgroundColor: Colors.pink,
      ),
      body: Stack(
        children: [
          // Fundo animado com base no progresso
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: MediaQuery.of(context).size.height * progress,
              width: double.infinity,
              child: BackgroundChallengeScreen(progress: progress),
            ),
          ),
          // Conteúdo principal da tela
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Fill it up!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Card(
                        color: task["completed"]
                            ? Colors.grey[300]
                            : Colors.white,
                        child: ListTile(
                          title: Text(task["name"]),
                          subtitle: Text("Dificuldade: ${task["difficulty"]}"),
                          trailing: task["completed"]
                              ? Icon(Icons.check, color: Colors.green)
                              : ElevatedButton(
                                  onPressed: () => markTaskAsCompleted(index),
                                  child: Text("Concluir"),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
