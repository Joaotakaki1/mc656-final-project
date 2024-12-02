import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mc656finalproject/utils/colors.dart';
import 'background_challenge_screen.dart';
import 'success_screen.dart';
import 'package:mc656finalproject/models/desafio.dart';

class DailyProgressScreen extends StatefulWidget {
  final List<Desafio> desafios;

  const DailyProgressScreen({super.key, required this.desafios});

  @override
  _DailyProgressScreenState createState() => _DailyProgressScreenState();
}

class _DailyProgressScreenState extends State<DailyProgressScreen> {
  late List<Map<String, dynamic>> tasks;

  @override
  void initState() {
    super.initState();
    tasks = widget.desafios.map((desafio) {
      return {
        "name": desafio.desafio,
        "completed": false,
      };
    }).toList();
  }

  // Função para marcar uma tarefa como concluída
  void markTaskAsCompleted(int index) {
    setState(() {
      tasks[index]["completed"] = true;

      // Verifica se todas as tarefas foram concluídas
      if (tasks.every((task) => task["completed"])) {
        Future.delayed(const Duration(milliseconds: 800), () {
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
      body: Stack(
        children: [
          // Fundo animado com base no progresso
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
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
                Row(
                  children: [
                    GestureDetector(
                      child: Image.asset('assets/icons/return.png', width: 40),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 45,
                    ),
                    const Text(
                      "Fill it up!",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: darkPink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Card(
                        color:
                            task["completed"] ? Colors.grey[300] : Colors.white,
                        child: ListTile(
                          title: Text(task["name"]),
                          trailing: task["completed"]
                              ? const Icon(Icons.check, color: Colors.green)
                              : ElevatedButton(
                                  onPressed: () => markTaskAsCompleted(index),
                                  child: const Text("Concluir"),
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
