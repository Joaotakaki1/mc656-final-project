import 'package:flutter/material.dart';
import 'package:mc656finalproject/models/user.dart';
import 'package:mc656finalproject/services/challenge_controller.dart';
import 'package:mc656finalproject/services/gamification_controller.dart';
import 'package:mc656finalproject/utils/colors.dart';
import 'package:provider/provider.dart';
import 'background_challenge_screen.dart';
import 'success_screen.dart';
import 'package:mc656finalproject/models/desafio.dart';
import 'package:mc656finalproject/services/data_base_controller.dart';

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

      // Move a tarefa concluída para o final da lista
      final completedTask = tasks.removeAt(index);
      tasks.add(completedTask);

      // Verifica se todas as tarefas foram concluídas
      if (tasks.every((task) => task["completed"])) {
        DataBaseController.updateCompletedChallenges(widget.currentUser.uid, true);
        GamificationController.milestoneStreak(true, widget.currentUser.uid);
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
          title: Text(
            task["name"],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  "ODS: ${task["ods"]}",
                  style: const TextStyle(fontWeight: FontWeight.bold),

                ),
                const SizedBox(height: 8),
                Text(
                  task["desc"],
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 16),
                const Text(

                  "Pessoas Afetadas:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: task["pessoas_afetadas"] / 40,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                ),
                const SizedBox(height: 8),
                Text(
                  "${task["pessoas_afetadas"]} / 40",
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Quantidade de Copos:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: task["qnt_copos"] / 40,
                  backgroundColor: Colors.grey[300],
                  color: Colors.green,
                ),
                const SizedBox(height: 8),
                Text(
                  "${task["qnt_copos"]} / 40",
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
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
  final Size screenSize = MediaQuery.of(context).size;
  final double screenHeight = screenSize.height;


  return Scaffold(
    appBar: AppBar(
      title: Text('Daily Progress'),
    ),
    body: Stack(
      children: [
       
        // Colocando os cards sobre o fundo
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    // Primeiro Card
                    Expanded(
                      child: Card(
                        color: tasks[0]["completed"] ? Colors.grey[300] : Colors.white,
                        child: ListTile(
                          leading: Image.asset('assets/icons/ods_icons/${tasks[0]["ods"]}.png'),
                          title: Text(tasks[0]["name"]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () => showTaskInfoDialog(context, tasks[0]),
                                child: const Text("Info"),
                              ),
                              const SizedBox(width: 8),
                              tasks[0]["completed"]
                              ? const Icon(Icons.check, color: Colors.green)
                              :
                              ElevatedButton(
                                onPressed: () => markTaskAsCompleted(0),
                                child: const Text("Concluir"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Segundo Card
                    
                    Expanded(
                      child: Card(
                        color: tasks[1]["completed"] ? Colors.grey[300] : Colors.white,
                        child: ListTile(
                          leading: Image.asset('assets/icons/ods_icons/${tasks[1]["ods"]}.png'),
                          title: Text(tasks[1]["name"]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () => showTaskInfoDialog(context, tasks[1]),
                                child: const Text("Info"),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => markTaskAsCompleted(1),
                                child: const Text("Concluir"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Terceiro Card
                    Expanded(
                      child: Card(
                        color: tasks[2]["completed"] ? Colors.grey[300] : Colors.white,
                        child: ListTile(
                          leading: Image.asset('assets/icons/ods_icons/${tasks[2]["ods"]}.png'),
                          title: Text(tasks[2]["name"]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () => showTaskInfoDialog(context, tasks[2]),
                                child: const Text("Info"),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => markTaskAsCompleted(2),
                                child: const Text("Concluir"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
         // Fundo animado com base no progresso
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: screenHeight * progress, // Isso faz com que ocupe toda a altura disponível
              width: double.infinity,  // Isso faz com que ocupe toda a largura disponível
              child: BackgroundChallengeScreen(progress: progress),
            ),
          ),
        ),
      ],
    ),
  );
}
}


