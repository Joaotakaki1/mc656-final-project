import 'package:flutter/material.dart';
import 'package:mc656finalproject/models/user.dart';
import 'package:mc656finalproject/services/challenge_controller.dart';
import 'package:mc656finalproject/utils/colors.dart';
import 'package:provider/provider.dart';
import 'background_challenge_screen.dart';
import 'success_screen.dart';
import 'package:mc656finalproject/models/desafio.dart';

class DailyProgressScreen extends StatefulWidget {
  final List<Desafio> desafios;
  final User currentUser;

  const DailyProgressScreen({super.key, required this.desafios, required this.currentUser});

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
        "ods": desafio.tema,
        "desc": desafio.descricao,
        "pessoas_afetadas": desafio.pessoasAfetadas,
        "qnt_copos": desafio.coposPlasticos,
        "completed": false,
      };
    }).toList();
  }

  // Função para marcar uma tarefa como concluída
  void markTaskAsCompleted(int index) {
    final challengeController = Provider.of<ChallengeController>(context, listen: false);
    setState(() {
      tasks[index]["completed"] = true;
      final completedDesafio = widget.desafios.firstWhere((desafio) => desafio.desafio == tasks[index]["name"]);
      challengeController.completedChallenge(completedDesafio);
      // Verifica se todas as tarefas foram concluídas
      if (tasks.every((task) => task["completed"])) {
        //TODO: aumentar 1 
        Future.delayed(const Duration(milliseconds: 800), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SuccessScreen(currentUser: widget.currentUser)),
          );
        });
      }
    });
  }

  // Função para mostrar o Dialog com informações do ListTile
  void showTaskInfoDialog(BuildContext context, Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(task["name"]),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("ODS: ${task["ods"]}"),
                Text("Descrição: ${task["desc"]}"),
                Text("Pessoas Afetadas: ${task["pessoas_afetadas"]}"),
                Text("Quantidade de Copos: ${task["qnt_copos"]}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Fechar"),
            ),
          ],
        );
      },
    );
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
                        color: task["completed"] ? Colors.grey[300] : Colors.white,
                        child: ListTile(
                          leading: Image.asset('${'assets/icons/ods_icons/' + task["ods"]}.png'), // Adiciona a imagem ao lado esquerdo do título
                          title: Text(task["name"]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () => showTaskInfoDialog(context, task),
                                child: const Text("Info"),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => markTaskAsCompleted(index),
                                child: const Text("Concluir"),
                              ),
                            ],
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