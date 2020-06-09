<?xml version="1.0" encoding="utf-8"?>

<!-- this file: FulPlaceOnHoldShelfLetter.xsl -->
<!-- Historique de mise à jour Campus Condorcet
     2020-06-09 JCS : adaptation temporaire pour guichet GED (période COVID-19)
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />
<!-- COURRIER ENVOYE A L'USAGER QUAND ON "SCAN IN" UNE RESERVATION
QUI L'ATTEND DESORMAIS EN BUREAU DE CIRC POUR X JOURS -->

<xsl:template match="/">
	<html>
		<head>
			<xsl:call-template name="generalStyle" />
		</head>
		<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
			<xsl:call-template name="head" /> <!-- header.xsl -->
			<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
			<xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->					
			<div class="messageArea">
				<div class="messageBody">
					<table cellspacing="0" cellpadding="5" border="0">
						<tr>
							<td>@@following_item_requested_on@@ <xsl:value-of select="notification_data/request/create_date"/>, @@can_picked_at@@ 
							<!--<xsl:value-of select="notification_data/request/assigned_unit_name"/> @@circulation_desk@@.-->
							</td>
						</tr>
						<xsl:if test="notification_data/request/work_flow_entity/expiration_date">
							<tr>
								<td>@@note_item_held_until@@ <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>.</td>
							</tr>
						</xsl:if>
						<tr>
							<td>
								<xsl:choose>
									<xsl:when test="notification_data/phys_item_display/title_abcnph != ''">
										<xsl:value-of select="notification_data/phys_item_display/title_abcnph"/>
									</xsl:when>		
									<xsl:otherwise>
										<xsl:call-template name="recordTitle" /> <!-- recordTitle.xsl -->
									</xsl:otherwise>								
								</xsl:choose>							
							</td>
						</tr>
						<!-- 2020-06-09 JCS : adaptation temporaire pour guichet de prêt COVID 19 -->
						<tr>
							<td><b>Le retrait se fait sans rendez-vous au guichet de prêt que nous avons mis en place tous les jeudis, du 11 juin au 23 juillet, de 10h à 16h.</b>
								Il se trouve dans le hall d’accueil de la Maison des Sciences de l’Homme Paris Nord [20, avenue George Sand - 93210 Saint-Denis La Plaine], 
								selon des modalités adaptées au contexte de crise sanitaire en cours. 
								En revanche, la consultation sur place de documentation ou d’archives ne sera pas possible, de même que le retour des documents.
								<br/><br/>Le port d’un masque est obligatoire pour accéder aux locaux, tout comme le respect des gestes barrière.
								<br/><br/>Tous les emprunts – y compris ceux réalisés avant le confinement – sont prolongés jusqu’au 19 octobre 2020.
							</td>
						</tr>
						<!-- 2020-06-09 JCS : fin de code -->
						<xsl:if test="notification_data/request/system_notes != ''">
							<tr>
								<td><b>@@notes_affect_loan@@:</b></td>
							</tr>
							<tr>
								<td><xsl:value-of select="notification_data/request/system_notes"/></td>
							</tr>
						</xsl:if>
					</table>
				</div>
			</div> 
			<br />
			<table>
				<tr><td>@@sincerely@@</td></tr>
				<tr><td>@@department@@</td></tr>
			</table>
			<!-- nicomo: remove footer.xsl
			<xsl:call-template name="lastFooter" /> 
			-->
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>