// import 'package:help_me_store/Model/cutomers_Model.dart';
// import 'package:flutter/material.dart';
// import 'package:help_me_store/Model/Tickets_Model.dart';
// import 'package:uuid/uuid.dart';

// enum TicketStatus { assigned, accepted, finished }

// class Tickets {
//   String id;
//   String? tickername;
//   String? taskType;
//   DateTime? date;
//   String? note;
//   Customers? customer;
//   String? contactPerson;
//   String? contactNumber;
//   String? serviceteam;
//   TicketStatus status;

//   Tickets({
//     required this.id,
//     this.tickername,
//     this.taskType,
//     this.date,
//     this.note,
//     this.customer,
//     this.contactPerson,
//     this.contactNumber,
//     this.serviceteam,
//     this.status = TicketStatus.assigned,
//   });
// }

// class TicketTypes {
//   final String ticketType;
//   TicketTypes({required this.ticketType});
// }

// List<String> TicketType = [
//   'Installation',
//   'Repair',
//   'Inspection',
//   'Delivery',
//   'Claim',
// ];




// class TicketProvider with ChangeNotifier {
//   List<Ticket> _tickets = [];
//   var uuid = Uuid();

//   List<Ticket> get tickets => _tickets;
//   // Assign a unique ID to the new Ticket
//   void addTicket(Ticket ticket) {
//     Ticket.id = uuid.v4();
//     _Tickets.add(Ticket);
//     notifyListeners();
//   }

//   void updateTicket(Ticket updatedTicket) {
//     int index = _tickets.indexWhere((ticket) => ticket.id == updatedTicket.id);
//     if (index != -1) {
//       _tickets[index] = updatedTicket;
//       notifyListeners();
//     }
//   }

//   void removeTicket(Ticket ticket) {
//     _tickets.removeWhere((t) => t.id == ticket.id);
//     notifyListeners();
//   }

//   void acceptTicket(Ticket ticket) {
//     Ticket.status = TicketStatus.accepted;
//     notifyListeners();
//   }

//   void finishTicket(Ticket ticket) {
//     Ticket.status = TicketStatus.finished;
//     notifyListeners();
//   }

//   void reassignTicket(Ticket ticket) {
//     Ticket.status = TicketStatus.assigned;

//     notifyListeners();
//   }

//   void revertTicketToAccepted(Ticket ticket) {
//     Ticket.status = TicketStatus.accepted;

//     notifyListeners();
//   }

//   void clearServiceTeam(Ticket ticket) {
//     ticket.serviceteam = null;

//     notifyListeners();
//   }
// }


