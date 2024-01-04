import unittest
from unittest.mock import patch
from io import StringIO
from project import get_user_input, voice_recognition, activate_assistant, process_and_speak


class TestYourFunctions(unittest.TestCase):

    @patch('builtins.input', side_effect=['Test Input'])
    def test_get_user_input(self, mock_input):
        result = get_user_input()
        self.assertEqual(result, 'Test Input')

    @patch('builtins.input', side_effect=['Test Dictation'])
    @patch('speech_recognition.Recognizer.recognize_google', return_value='Test Dictation')
    def test_voice_recognition(self, mock_recognize_google, mock_input):
        result = voice_recognition()
        self.assertEqual(result, 'Test Dictation')

    @patch('pyttsx3.init')
    @patch('pyttsx3.Engine.say')
    @patch('pyttsx3.Engine.runAndWait')
    @patch('wikipedia.summary', return_value='Test Wikipedia Summary')
    def test_process_and_speak(self, mock_summary, mock_runAndWait, mock_say, mock_init):
        with patch('sys.stdout', new_callable=StringIO) as mock_stdout:
            process_and_speak('Test Input')
            output = mock_stdout.getvalue().strip()

        self.assertIn('Wikipedia Answer: Test Wikipedia Summary', output)


if __name__ == '__main__':
    unittest.main()
