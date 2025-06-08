# Python Project Scaffold

This is a basic Python project scaffolded for development in Visual Studio Code.

## Getting Started

1. **Set up the virtual environment and install dependencies:**
   ```bash
   bash run.sh
   ```
   This will create (if needed) and activate a `.env` virtual environment, then install dependencies from `requirements.txt`.

2. **Add your Python code:**
   Place your source files in the project directory. Update `requirements.txt` as needed.

3. **Run your application:**
   Add your start command to `run.sh` (e.g., `python main.py`).

## Docker Usage

To build and run the project in Docker:
```bash
docker build -t my-python-app .
docker run -it --rm my-python-app
```

---

For more details, see the comments in `run.sh` and `Dockerfile`.
