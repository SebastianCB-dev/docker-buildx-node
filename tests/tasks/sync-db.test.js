const { syncDB } = require('../../tasks/sync-db');


describe('Pruebas en SyncDB', () => {
  test('debe de ejecutar el proceso 2 veces', () => {

    syncDB();
    const res = syncDB();
    expect(res).toBe(2);

  });
});