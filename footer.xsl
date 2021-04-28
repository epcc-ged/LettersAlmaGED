<?xml version="1.0" encoding="utf-8"?>

<!-- this file: footer.xsl -->
<!-- Historique de mise à jour Campus Condorcet
	 2021-04-28 JCS : refonte complète
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template name="lastFooter">
	<center>
		<table>
			<xsl:attribute name="style">
				<xsl:call-template name="footerTableStyleCss" /> 
			</xsl:attribute>
			<tr>
				<td>Grand équipement documentaire - Campus Condorcet</td>
			</tr>
			<tr>
				<td><a href="https://www.campus-condorcet.fr/le-ged">https://www.campus-condorcet.fr/le-ged</a></td>
			</tr>
		</table>
	</center>
</xsl:template>
</xsl:stylesheet>