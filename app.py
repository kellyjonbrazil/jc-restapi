import json
from flask import Flask, request
from werkzeug.exceptions import HTTPException
from jc import __version__, standard_parser_mod_list, parse, parser_info


DEBUG = False

app = Flask(__name__)

# --- Custom Errors ---
class NoData(HTTPException):
    code = 400
    description = 'No data in request.'


# --- ROUTES ---
@app.route('/v1/version', methods=['GET'])
def version():
    return {
        "version": __version__
    }

@app.route('/v1/parsers', methods=['GET'])
def parsers():
    return {
        "parsers": standard_parser_mod_list(show_hidden=True)
    }

@app.route('/v1/<parser_name>/info', methods=['GET'])
def parser_documentation(parser_name):
    return {
        "parser": parser_name,
        "info": parser_info(parser_name, documentation=True)
    }

@app.route('/v1/<parser_name>/parse', methods=['POST'])
def parse_data(parser_name):
    request_data = request.get_json()
    data = request_data.get('data')
    raw = request_data.get('raw', False)

    if not data:
        raise NoData

    return {"result": parse(parser_name, data, raw=raw)}

# --- Error handler
@app.errorhandler(HTTPException)
def handle_exception(e):
    response = e.get_response()
    response.data = json.dumps({
        "code": e.code,
        "error": e.name,
        "description": e.description,
    })
    response.content_type = "application/json"
    return response


if __name__ == '__main__':
    app.run(debug=DEBUG)
