class DirectoryStudent {
  final String name;
  final String usn;
  final String branch;
  final String year;

  const DirectoryStudent({
    required this.name,
    required this.usn,
    required this.branch,
    required this.year,
  });
}

class DirectoryStop {
  final String name;
  final List<DirectoryStudent> students;

  const DirectoryStop({
    required this.name,
    required this.students,
  });
}

class DirectoryBus {
  final String busNumber;
  final String route;
  final List<DirectoryStop> stops;

  const DirectoryBus({
    required this.busNumber,
    required this.route,
    required this.stops,
  });
}

class DemoStudentDirectory {
  static List<DirectoryBus> get buses {
    return [
      DirectoryBus(
        busNumber: 'Bus 1',
        route: 'Hospet → Gangavathi → Koppal → University',
        stops: [
          DirectoryStop(
            name: 'Hospet',
            students: [
              DirectoryStudent(
                name: 'Moin',
                usn: 'KUB24CSE118',
                branch: 'CSE',
                year: '3rd Year',
              ),
              DirectoryStudent(
                name: 'Mohammed Mansoor',
                usn: 'KUB24CSE119',
                branch: 'CSE',
                year: '3rd Year',
              ),
              DirectoryStudent(
                name: 'Student C',
                usn: 'KUB25ECE101',
                branch: 'ECE',
                year: '2nd Year',
              ),
            ],
          ),
          DirectoryStop(
            name: 'Gangavathi',
            students: [
              DirectoryStudent(
                name: 'Student D',
                usn: 'KUB25ISE104',
                branch: 'ISE',
                year: '2nd Year',
              ),
              DirectoryStudent(
                name: 'Student E',
                usn: 'KUB26AIML110',
                branch: 'AIML',
                year: '1st Year',
              ),
            ],
          ),
          DirectoryStop(
            name: 'Koppal',
            students: [
              DirectoryStudent(
                name: 'Student F',
                usn: 'KUB24CSE125',
                branch: 'CSE',
                year: '3rd Year',
              ),
            ],
          ),
        ],
      ),

      DirectoryBus(
        busNumber: 'Bus 2',
        route: 'Gangavathi → University',
        stops: [
          DirectoryStop(
            name: 'Gangavathi',
            students: [
              DirectoryStudent(
                name: 'Rahul Kumar',
                usn: 'KUB25ECE101',
                branch: 'ECE',
                year: '2nd Year',
              ),
              DirectoryStudent(
                name: 'Anjali',
                usn: 'KUB25ISE104',
                branch: 'ISE',
                year: '2nd Year',
              ),
            ],
          ),
          DirectoryStop(
            name: 'Stop 2',
            students: [
              DirectoryStudent(
                name: 'Student G',
                usn: 'KUB24CSE126',
                branch: 'CSE',
                year: '3rd Year',
              ),
            ],
          ),
          DirectoryStop(
            name: 'Stop 3',
            students: [],
          ),
        ],
      ),

      DirectoryBus(
        busNumber: 'Bus 3',
        route: 'Koppal → University',
        stops: [
          DirectoryStop(
            name: 'Koppal',
            students: [
              DirectoryStudent(
                name: 'Arun',
                usn: 'KUB26AIML110',
                branch: 'AIML',
                year: '1st Year',
              ),
              DirectoryStudent(
                name: 'Student H',
                usn: 'KUB25CSE130',
                branch: 'CSE',
                year: '2nd Year',
              ),
            ],
          ),
          DirectoryStop(
            name: 'Stop 2',
            students: [],
          ),
        ],
      ),

      _emptyBus('Bus 4', 'Route 4 → University'),
      _emptyBus('Bus 5', 'Route 5 → University'),
      _emptyBus('Bus 6', 'Route 6 → University'),
      _emptyBus('Bus 7', 'Route 7 → University'),
      _emptyBus('Bus 8', 'Route 8 → University'),
      _emptyBus('Bus 9', 'Route 9 → University'),
      _emptyBus('Bus 10', 'Route 10 → University'),
      _emptyBus('Bus 11', 'Route 11 → University'),
      _emptyBus('Bus 12', 'Route 12 → University'),
      _emptyBus('Bus 13', 'Route 13 → University'),
      _emptyBus('Bus 14', 'Route 14 → University'),
      _emptyBus('Bus 15', 'Route 15 → University'),
      _emptyBus('Bus 16', 'Route 16 → University'),
      _emptyBus('Bus 17', 'Route 17 → University'),
      _emptyBus('Bus 18', 'Route 18 → University'),
      _emptyBus('Bus 19', 'Route 19 → University'),
      _emptyBus('Bus 20', 'Route 20 → University'),
      _emptyBus('Bus 21', 'Route 21 → University'),
      _emptyBus('Bus 22', 'Route 22 → University'),
      _emptyBus('Bus 23', 'Route 23 → University'),
      _emptyBus('Bus 24', 'Route 24 → University'),
    ];
  }

  static DirectoryBus _emptyBus(
      String busNumber,
      String route,
      ) {
    return DirectoryBus(
      busNumber: busNumber,
      route: route,
      stops: const [
        DirectoryStop(
          name: 'Stop 1',
          students: [],
        ),
        DirectoryStop(
          name: 'Stop 2',
          students: [],
        ),
        DirectoryStop(
          name: 'Stop 3',
          students: [],
        ),
      ],
    );
  }
}