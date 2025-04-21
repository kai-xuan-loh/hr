import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hr/api/api_model.dart';
import 'package:hr/universal/theme.dart';
import 'package:intl/intl.dart';

class CardEvent extends StatelessWidget {
  final dynamic event; // Can be Event or Events

  const CardEvent({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Title: ${_getEventTitle(event)}",
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
          ),
          const SizedBox(height: 5),

          AutoSizeText(
            "Location: ${_getEventLocation(event)}",
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 1,
          ),
          const SizedBox(height: 5),

          AutoSizeText(
            "Apply by: ${_getApplyBy(event)}",
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 1,
          ),
          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                _getEventDate(event),
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
              ),
              AutoSizeText(
                _getEventTime(event),
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                "Status: ${_getEventStatus(event)}",
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
              ),
              Icon(Icons.info, color: _getStatusColor(_getEventStatus(event))),
            ],
          ),
        ],
      ),
    );
  }

  bool isEvent(dynamic event) => event is Event;
  bool isEvents(dynamic event) => event is Events;

  String _getEventTitle(dynamic event) {
    return (isEvent(event) || isEvents(event)) && event.event_name.isNotEmpty
        ? event.event_name
        : "Untitled Event";
  }

  String _getEventDate(dynamic event) {
    if (isEvent(event)) {
      return event.date.isNotEmpty ? "Date : ${formatDate(event.date)}" : "No date provided";
    } else if (isEvents(event)) {
      return event.start_date.isNotEmpty ? "Start Date : ${formatDate(event.start_date)}" : "No date provided";
    }
    return "No date provided";
  }

  String _getEventLocation(dynamic event) {
    return (isEvent(event) || isEvents(event)) && event.location.isNotEmpty
        ? event.location
        : "No location provided";
  }

  String _getApplyBy(dynamic event) {
    return (isEvent(event) || isEvents(event)) && event.applyBy.isNotEmpty
        ? event.applyBy
        : "No apply by";
  }

  String _getEventTime(dynamic event) {
    if (isEvent(event)) {
      return event.time.isNotEmpty ? "Time : ${formatTime(event.time)}" : "No time provided";
    } else if (isEvents(event)) {
      return event.end_date.isNotEmpty ? "End date: ${formatDate(event.end_date)}" : "No time provided";
    }
    return "No time provided";
  }

  String _getEventStatus(dynamic event) {
    return (isEvent(event) || isEvents(event)) && event.status.isNotEmpty
        ? event.status
        : "No status available";
  }

  String formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
      return DateFormat("MMM dd, yyyy").format(parsedDate);
    } catch (e) {
      return "Invalid date";
    }
  }

  String formatTime(String time) {
    try {
      DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
      return DateFormat("h:mm a").format(parsedTime);
    } catch (e) {
      return "Invalid time";
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
