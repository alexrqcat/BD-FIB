
/* Imports de la classe */
import java.sql.*;

/* Capa de Control de Dades */
class CtrlDadesPublic extends CtrlDadesPrivat {

	public ConjuntTuples consulta(Connection c, Tuple params) throws BDException {
		try {
			ConjuntTuples ct = new ConjuntTuples();
			Statement s = c.createStatement();
			ResultSet rs = s.executeQuery("select dni from professors");
			int trobat = 0;
			PreparedStatement ps = c.prepareStatement("select a.modul, a.numero from assignacions a where a.dni = ? and a.instantfi is null;");
			PreparedStatement ps1 = c.prepareStatement("select a.modul, a.numero from assignacions a where a.dni = ? and " +
			"a.instantfi = (select max(a1.instantfi) from assignacions a1 where a1.dni = ? group by a1.dni);");
			while(rs.next()) {
				trobat = 1;
				ResultSet r = null;
				Tuple fila = new Tuple();
				String dni = rs.getString("dni");
				fila.afegir(dni);
				ps.setString(1, dni);
				r = ps.executeQuery();
				if(!r.next()) {
					ps1.setString(1, dni);
					ps1.setString(2, dni);
					r = ps1.executeQuery();
					if(!r.next()) {
						fila.afegir("XXX");
						fila.afegir("YYY");
					}
					else {
						fila.afegir(r.getString(1));
						fila.afegir(r.getString(2));
					}
				}
				else {
					fila.afegir(r.getString(1));
					fila.afegir(r.getString(2));
				}
				ct.afegir(fila);
			}
			if(trobat == 0) throw new BDException(10);
			return ct;
		}
		catch(SQLException se) {
			throw new BDException(11);
		}
	}
}
