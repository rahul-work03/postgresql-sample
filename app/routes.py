from flask import Blueprint, jsonify
from .db import get_conn

bp = Blueprint("api", __name__)

@bp.route("/users")
def users():
    with get_conn() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT id, email, username FROM users")
            rows = cur.fetchall()

    return jsonify([
        {"id": r[0], "email": r[1], "username": r[2]}
        for r in rows
    ])
