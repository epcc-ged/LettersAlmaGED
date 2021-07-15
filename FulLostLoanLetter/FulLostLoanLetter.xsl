<?xml version="1.0" encoding="utf-8"?>

<!-- this file: FulLostLoanLetter.xsl -->
<!-- Historique de mise à jour Campus Condorcet
     2021-07-15 JCS : refonte de la lettre
-->

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
	<html>
		<xsl:if test="notification_data/languages/string">
			<xsl:attribute name="lang">
				<xsl:value-of select="notification_data/languages/string"/>
			</xsl:attribute>
		</xsl:if>

		<head>
			<title>
				<xsl:value-of select="notification_data/general_data/subject"/>
			</title>
			<xsl:call-template name="generalStyle" />
		</head>

		<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
			<xsl:call-template name="head" /> <!-- header.xsl -->
			<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

			<br />

			<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
				<tr>
					<td>
						<h>@@inform_you_item_below@@ </h>
					</td>
				</tr>
			</table>

			<table cellpadding="5" class="listing">
				<xsl:attribute name="style">
					<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>

				<xsl:for-each select="notification_data">     
					<table role='presentation' >
						<tr>
							<td>
								<strong>@@lost_item@@ :</strong> <xsl:value-of select="item_loan/title"/>
								<br />
								<strong>@@description@@ :</strong><xsl:value-of select="item_loan/description"/>
								<br />
								<strong> @@by@@ :</strong><xsl:value-of select="item_loan/author"/>
								<br />
								<strong>@@library@@ :</strong><xsl:value-of select="organization_unit/name"/>
								<br />
								<strong>@@loan_date@@ :</strong><xsl:value-of select="item_loan/loan_date"/>
								<br />
								<strong>@@due_date@@ :</strong><xsl:value-of select="item_loan/due_date"/>
								<br />
								<strong>@@barcode@@ :</strong><xsl:value-of select="item_loan/barcode"/>
								<br />
								<strong>@@call_number@@ :</strong><xsl:value-of select="phys_item_display/call_number"/>
								<br />
							</td>
						</tr>
					</table>
				</xsl:for-each>
				<br />
				<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>
							<h>@@additional_info_1@@</h>
						</td>
					</tr>
				</table>
				<br />
				<table role='presentation' >
	
						<tr><td>@@sincerely@@</td></tr>
						<tr><td>@@department@@</td></tr>
	
				</table>
			</table>
			<br />
			<xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
		</body>
	</html>
</xsl:template>

</xsl:stylesheet>