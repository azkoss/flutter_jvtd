import 'dart:async';

///定时器回调
typedef void OnTimerCallback(int millisUntilFinished);

///定时器工具
class TimerUtil {
  TimerUtil({this.mInterval: Duration.millisecondsPerSecond, this.mTotalTime});

  ///Timer.
  Timer _mTimer;

  ///Timer是否启动.
  bool _isActive = false;

  ///Timer间隔 单位毫秒，默认1000毫秒(1秒).
  int mInterval;

  ///倒计时总时间
  int mTotalTime; //单位毫秒

  OnTimerCallback _onTimerCallback;

  ///设置Timer间隔.
  void setInterval(int interval) {
    if (interval <= 0) interval = Duration.millisecondsPerSecond;
    mInterval = interval;
  }

  ///设置倒计时总时间.
  void setTotalTime(int totalTime) {
    if (totalTime <= 0) return;
    mTotalTime = totalTime;
  }

  ///启动定时Timer.
  void startTimer() {
    if (_isActive || mInterval <= 0) return;
    _isActive = true;
    Duration duration = Duration(milliseconds: mInterval);
    _doCallback(0);
    _mTimer = Timer.periodic(duration, (Timer timer) {
      _doCallback(timer.tick);
    });
  }

  ///启动倒计时Timer.
  void startCountDown() {
    if (_isActive || mInterval <= 0 || mTotalTime <= 0) return;
    _isActive = true;
    Duration duration = Duration(milliseconds: mInterval);
    _doCallback(mTotalTime);
    _mTimer = Timer.periodic(duration, (Timer timer) {
      int time = mTotalTime - mInterval;
      mTotalTime = time;
      if (time >= mInterval) {
        _doCallback(time);
      } else if (time == 0) {
        _doCallback(time);
        cancel();
      } else {
        timer.cancel();
        Future.delayed(Duration(milliseconds: time), () {
          mTotalTime = 0;
          _doCallback(0);
          cancel();
        });
      }
    });
  }

  void _doCallback(int time) {
    if (_onTimerCallback != null) {
      _onTimerCallback(time);
    }
  }

  ///重设倒计时总时间.
  void updateTotalTime(int totalTime) {
    cancel();
    mTotalTime = totalTime;
    startCountDown();
  }

  ///Timer是否启动.
  bool isActive() {
    return _isActive;
  }

  ///取消计时器.
  void cancel() {
    if (_mTimer != null) {
      _mTimer.cancel();
      _mTimer = null;
    }
    _isActive = false;
  }

  ///set timer callback.
  void setOnTimerCallback(OnTimerCallback callback) {
    _onTimerCallback = callback;
  }
}