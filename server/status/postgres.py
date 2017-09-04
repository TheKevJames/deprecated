import ssl

import asyncpg

from .values import Status


SSL_CONTEXT = ssl.SSLContext(ssl.PROTOCOL_SSLv23)


async def get_pg_status(url):
    conn = await asyncpg.connect(dsn=url, ssl=SSL_CONTEXT, timeout=3)
    rows = await conn.fetch('SELECT 1')
    return Status.GREEN if rows[0][0] == 1 else Status.RED
