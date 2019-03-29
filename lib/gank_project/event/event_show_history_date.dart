class ShowHistoryDateEvent {
  bool forceHide = false;

  ShowHistoryDateEvent();

  ShowHistoryDateEvent.hide() {
    forceHide = true;
  }
}
