<?xml version="1.0" encoding="utf-8"?>

<!-- this file: FulUserLoansCourtesyLetter.xsl -->
<!-- Historique de mise à jour Campus Condorcet
     2021-01-05 JCS : adaptation pour prise de rdv pendant le Covid
	 2021-04-21 JCS : adaptation pour le 3e confinement non-confiné (période COVID-19)
     2021-06-30 JCS : suppression du lien Evento de prise rdv Covid
	 2023-12-21 JCS : ajout d'un message pour le prolongement avec lien vers le catalogue
-->


<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />

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
				<xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
			</xsl:attribute>
			<xsl:call-template name="head" /><!-- header.xsl -->
			<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
			<xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

			<div class="messageArea">
				<div class="messageBody">
		
					<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>
							<xsl:if test="notification_data/short_loans='true'">
								@@short_loans_message@@
							</xsl:if>
							<xsl:if test="notification_data/short_loans='false'">
								@@message@@
							</xsl:if>
							<br/>
						</td>
					</tr>
					<tr>
						<td>
							<strong>@@loans@@</strong>
						</td>
					</tr>
		
					<tr>
						<td>
							<table  cellpadding="5" class="listing">
								<xsl:attribute name="style">
									<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
								</xsl:attribute>
								<tr>
									<th>@@title@@</th>
									<th>@@description@@</th>
									<th>@@author@@</th>
									<th>@@due_date@@</th>
									<th>@@library@@</th>
								</tr>
		
								<xsl:for-each select="notification_data/item_loans/item_loan">
								<tr>
									<td><xsl:value-of select="title"/></td>
									<td><xsl:value-of select="description"/></td>
									<td><xsl:value-of select="author"/></td>
									<td><xsl:value-of select="due_date"/></td>
									<td><xsl:value-of select="library_name"/></td>
		
								</tr>
								</xsl:for-each>
		
							</table>
						</td>
					</tr>
					</table>
					
					<p><b>Si vous souhaitez prolonger votre prêt, vous pouvez le faire depuis votre compte lecteur en vous connectant sur <a href="https://catalogue.humatheque-condorcet.fr/">le catalogue de l'Humathèque</a> et en vérifiant si cette possibilité est offerte pour le ou les exemplaire(s) concerné(s).</b></p>
		

					
					@@additional_info_2@@
					<br />
					<table role='presentation' >
						<tr><td>@@sincerely@@</td></tr>
						<tr><td>@@department@@</td></tr>
					</table>
		
				</div>
			</div>
	
			<!-- footer.xsl -->
			
			<xsl:call-template name="lastFooter" />
			
		</body>
    </html>
  </xsl:template>
</xsl:stylesheet>
