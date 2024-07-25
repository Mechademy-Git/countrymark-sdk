### Task Scheduler Configuration:

1. **Open Task Scheduler**:
   - Press `Windows + R`, type `taskschd.msc`, and press `Enter`.

2. **Create a New Task**:
   - In the Task Scheduler window, click on `Create Task...` in the right-hand Actions pane.

3. **General Tab**:
   - Name: `TurboDC`
   - Description: `Fetch data every 2 minutes and post to the endpoint`
   - Check `Run whether user is logged on or not`
   - Check `Run with highest privileges`

4. **Triggers Tab**:
   - Click `New...` to create a new trigger.
   - Begin the task: `On a schedule`
   - Settings: `Daily`
   - Repeat task every: `2 minutes`
   - For a duration of: `Indefinitely`
   - Click `OK`

5. **Actions Tab**:
   - Click `New...` to create a new action.
   - Action: `Start a program`
   - Program/script: `python` (or the full path to the Python executable)
   - Add arguments: `C:\path\to\main.py` (full path to your script)
   - Click `OK`

6. **Conditions Tab**:
   - Uncheck `Start the task only if the computer is on AC power` if you want the script to run on battery power as well.

7. **Settings Tab**:
   - Check `Allow task to be run on demand`
   - Check `Run task as soon as possible after a scheduled start is missed`
   - Check `If the task fails, restart every` and set it to `1 minute` for `3` attempts.
   - Click `OK`

8. **Save the Task**:
   - You may be prompted to enter your Windows password to allow the task to run with the highest privileges. Enter your password and click `OK`.

This setup ensures that your script runs every 2 minutes, checks whether it needs to fetch and push data, and only performs these actions if the last push was more than 30 minutes ago.
